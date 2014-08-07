Pod::Spec.new do |s|
  s.name         = "CHVariableHeightTilesLayout"
  s.version      = "1.0.0"
  s.summary      = "Custom collection view layout that has the same vertical spacing between all cells."
  s.description  = <<-DESC
                   Custom collection view layout that has the same vertical spacing between all cells. This allows for cells to break the default flow layout's horizontal alignment or rows.
                   DESC
  s.homepage     = "https://github.com/chaione/CHVariableHeightTilesLayout"
  s.screenshots  = "https://github.com/chaione/CHVariableHeightTilesLayout/raw/master/Misc/screenshot01.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Rogelio Gudino" => "cananito@gmail.com", "Matthew Morey" => "me@matthewmorey.com", "Osama Ashawa" => "osama@oashawa.com" }
  s.social_media_url = 'https://twitter.com/cananito'
  s.platform     = :ios
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/chaione/CHVariableHeightTilesLayout.git", :tag => "1.0.0" }
  s.source_files = "CHVariableHeightTilesLayout/*.{h,m}"
  s.requires_arc = true
end
