Pod::Spec.new do |s|

  s.name         = "JMFormDescription"
  s.version      = "0.0.2"
  s.summary      = "JMFormDescription is an iOS library for easily manage complex Form."
  s.requires_arc = true

  s.description  = <<-DESC
                   JMFormDescription is an Objective-C library for easily creating and manage complex structured Form.
                   * A new way to your layout in a very simple method,
                   * Datasource / Delegate considerably simplified and focus on manipulated objet, no indexPath!
                   * Next/Previous/Done inpoutAccesoryView for TextField and TextView.
                   DESC

  s.homepage     = "https://github.com/leverdeterre/JMFormDescription"
  s.screenshots  = "https://raw.githubusercontent.com/leverdeterre/JMFormDescription/master/screenshots/demo1.png",
                   "https://raw.githubusercontent.com/leverdeterre/JMFormDescription/master/screenshots/demo2.png",
                   "https://raw.githubusercontent.com/leverdeterre/JMFormDescription/master/screenshots/demo3.png"

  s.license      = 'MIT'
  s.author       = { "jerome Morissard" => "morissardj@gmail.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/leverdeterre/JMFormDescription.git", :tag => "0.0.2" }
  s.source_files = 'Classes', 'JMFormDescription/JMFormDescription/*.{h,m}'
  s.public_header_files = 'JMFormDescription/JMFormDescription/*.h'
  s.resources           = "JMFormDescription/JMFormDescription/*.xib"
  s.framework           = 'UIKit'
end
