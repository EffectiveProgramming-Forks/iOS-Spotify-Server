/*
 The MIT License (MIT)
 Copyright (c) 2013 Crocodella Software LTDA
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "MongooseServer.h"

@implementation MongooseServer

@synthesize servlets;
@synthesize ctx;

void *handleRequest(enum mg_event event,
                    struct mg_connection *conn,
                    const struct mg_request_info *request_info) {
    
    const char *cl;
    char *buf;
    int len;
    
    MongooseServer *server = (MongooseServer *)request_info->user_data;
    
    // Reads the body of the request
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSData *body = nil;
    
    if ((cl = mg_get_header(conn, "Content-Length")) != NULL) {
        
        len = atoi(cl);
        if ((buf = malloc(len)) != NULL) {
            mg_read(conn, buf, len);
            body = [NSData dataWithBytes:buf length:len];
            free(buf);
        }
    }
    
    NSString *path = [NSString stringWithUTF8String:request_info->uri];
    
    // Search for a servlet to respond to the exact path
    
    Servlet *servlet = [server.servlets valueForKey:path];
    
    // If an exact match is not found, tries to match wildcard servlets
    if (!servlet) {
        for (NSString *servletPath in server.servlets) {
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"self LIKE %@", servletPath];
            if ([pred evaluateWithObject:path]) {
                servlet = [server.servlets valueForKey:servletPath];
            }
        }
    }
    
    ServletResponse *response = nil;
    
    if (servlet) {
        
        ServletRequest *request = [[ServletRequest alloc] initWithRequestInfo:request_info body:body];
        
        if (strcmp(request_info->request_method, "GET") == 0) {
            response = [servlet doGet:request];
        } else if (strcmp(request_info->request_method, "POST") == 0) {
            response = [servlet doPost:request];
        }
        
    } else {
        
        // If directory listing is enabled and no servlet was found, let
        // Mongoose handle it
        
        if (strcmp(mg_get_option(server.ctx, "enable_directory_listing"), "yes") == 0) {
            
            return NULL;
            
        } else {
            
            // If no servlets were found to respond, sends a 404 error
            
            servlet = [[[Servlet alloc] init] autorelease];
            response = [servlet sendNotFound];
        }

    }
    
    NSData *resp = [response toBinary];
    
    mg_write(conn, [resp bytes], [resp length]);
    
    [pool release];
    
    return "handled";
}


- (id)initWithPort:(int)port allowDirectoryListing:(BOOL)listing {
    if ((self = [super init])) {
        
        NSString *portStr = [NSString stringWithFormat:@"%d", port];
        
        const char *options[] = {
            "document_root", [NSHomeDirectory() UTF8String],
            "listening_ports", [portStr UTF8String],
            "enable_directory_listing", listing ? "yes" : "no",
            NULL
        };
        
        ctx = mg_start(handleRequest, self, options);
        
        servlets = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

- (id)initWithOptions:(const char *[])options {
    
    if ((self = [super init])) {
        
        ctx = mg_start(handleRequest, self, options);
        
        servlets = [[NSMutableDictionary alloc] init];
        
    }
    return self;

}

- (void)dealloc {
    
    mg_stop(ctx);
    [servlets release];
    [super dealloc];
}

- (void)addServlet:(Servlet *)servlet forPath:(NSString *)path {
    [servlets setValue:servlet forKey:path];
}

- (void)removeServletForPath:(NSString *)path {
    [servlets removeObjectForKey:path];
}

@end
