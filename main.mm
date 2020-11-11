#import "ac1d.h"

NSArray *commands = [[NSArray alloc] initWithObjects:
    @"home", 
    @"dhome",
    @"locon",
    @"locoff", nil];

NSArray *reply_commands = [[NSArray alloc] initWithObjects:
    @"battery",
    @"state", nil];

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        ac1d *ac1d_base = [[ac1d alloc] init];
        if (argc < 2) printf("Usage: ac1d <option>\n");
        else {
            NSMutableArray *args = [NSMutableArray array];
            for (int i = 0; i < argc; i++) {
                NSString *str = [[NSString alloc] initWithCString:argv[i] encoding:NSUTF8StringEncoding];
                [args addObject:str];
            }
            if ([args[1] isEqualToString:@"locate"]) {
                [ac1d_base locate];
            } else if ([args[1] isEqualToString:@"getvol"]) {
                [ac1d_base getvol];
            } else if ([args[1] isEqualToString:@"openurl"]) {
                if (argc < 3) printf("Usage: ac1d openurl <url>\n");
                else {
                    [ac1d_base openurl:args[2]];
                }
            } else if ([args[1] isEqualToString:@"openapp"]) {
                if (argc < 3) printf("Usage: ac1d openapp <application>\n");
                else {
                    [ac1d_base openapp:args[2]];
                }
            } else if ([args[1] isEqualToString:@"sysinfo"]) {
                [ac1d_base sysinfo];
            } else if ([args[1] isEqualToString:@"player"]) {
                if (argc < 3) printf("Usage: ac1d player [info]\n");
                else {
                    [ac1d_base player:args[2]];
                }
            } else if ([commands containsObject:args[1]]) {
                [ac1d_base send_command:args[1]];
            } else if ([reply_commands containsObject:args[1]]) {
                [ac1d_base send_reply_command:args[1]];
            } else printf("Usage: ac1d <option>\n");
        }
    }
    return 0;
}
