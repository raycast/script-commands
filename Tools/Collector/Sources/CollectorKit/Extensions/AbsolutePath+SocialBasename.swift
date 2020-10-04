// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import TSCBasic

extension AbsolutePath {
    
    var socialBasename: String {
        basenameWithoutExt.sanitize.capitalized
    }
    
}
