Pod::Spec.new do |s|

  s.name         = "JMFormDescription"
  s.version      = "0.0.1"
  s.summary      = "JMFormDescription is an iOS library for easily manage complex form."
  s.requires_arc = true

  s.description  = <<-DESC
                   JMFormDescription is an Objective-C library for easily creating and manage complex structured from.
                   * A new way to describe your tableView "layout" in a very simple method,
                   * Datasource / Delegate considerably simplified and focus on manipulated objet, no indexPath!
                   * The code produced using this implementation his highly customizable, reusable and flexible. (No more bugs?)
                   DESC

  s.homepage     = "https://github.com/leverdeterre/JMFormDescription"
  s.screenshots  = "https://raw.githubusercontent.com/leverdeterre/JMFormDescription/master/screenshots/demo1.png",
                   "https://raw.githubusercontent.com/leverdeterre/JMFormDescription/master/screenshots/demo2.png",
                   "https://raw.githubusercontent.com/leverdeterre/JMFormDescription/master/screenshots/demo3.png"

  s.license      = 'MIT'
  s.author       = { "jerome Morissard" => "morissardj@gmail.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/leverdeterre/JMFormDescription.git", :tag => "0.0.1" }
  s.source_files = 'Classes', 'JMFormDescription/JMFormDescription/*.{h,m}'
  s.framework    = 'UIKit'
end
