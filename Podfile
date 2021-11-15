# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
use_frameworks!

def gen_pod_list
# Alamofire ~ last updated 3 days ago
pod 'Alamofire', '~> 5.2'
pod 'AlamofireImage', '~> 4.1'
# SDWebImage ~ last updated 1 month
pod 'SDWebImage'
end


target 'KMCodingChallenge' do
  gen_pod_list
end

target 'KMCodingChallengeTests' do
    inherit! :search_paths
end

target 'KMCodingChallengeUITests' do

end
