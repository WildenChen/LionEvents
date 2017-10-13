Pod::Spec.new do |spec|
    spec.name        = "LionEvents"
    spec.version     = "0.10.2"
    spec.summary     = "Event Flow framework for iOS and tvOS."
    spec.homepage    = "https://github.com/WildenChen/LionEvents"
    spec.license     = { :type => "BSD" }
    spec.authors     = { "Lion Infomation Technology Co.,Ltd." => "wildenchen@liontravel.com.tw", "wilden" => "wilden0424@gmail.com" }
    spec.social_media_url = "https://twitter.com/wilden0424"
    
    spec.requires_arc = true
    #    spec.osx.deployment_target = "10.9"
    spec.ios.deployment_target = "8.0"
    spec.tvos.deployment_target = "9.0"
    spec.source   = { :git => "https://github.com/WildenChen/LionEvents.git", :tag => "#{spec.version}"}
    spec.source_files = "LionEvents/LionEvents/*"
end
