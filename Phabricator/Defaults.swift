//
//  Defaults.swift
//  Phabricator
//
//  Created by Feifan Zhou on 2/18/15.
//  Copyright (c) 2015 Feifan Zhou. All rights reserved.
//

import Foundation

class Defaults {
	class func set(object: AnyObject, key: String) {
		NSUserDefaults.standardUserDefaults().setObject(object, forKey: key)
	}
	class func get(key: String) -> AnyObject? {
		var objDict: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(key)
		return objDict
	}
	class func remove(key: String) {
		NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
	}
	class func delete(key: String) {
		Defaults.remove(key)
	}
	class func sync() {
		NSUserDefaults.standardUserDefaults().synchronize()
	}
}