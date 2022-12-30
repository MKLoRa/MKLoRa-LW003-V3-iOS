#
# Be sure to run `pod lib lint MKLoRaWAN-BV.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-BV'
  s.version          = '0.0.1'
  s.summary          = 'LW003-V3'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MKLoRa/MKLoRa-LW003-V3-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/MKLoRa/MKLoRa-LW003-V3-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  
  s.resource_bundles = {
    'MKLoRaWAN-BV' => ['MKLoRaWAN-BV/Assets/*.png']
  }
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-BV/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.subspec 'SyncDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-BV/Classes/DatabaseManager/SyncDatabase/**'
    end
    
    ss.subspec 'LogDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-BV/Classes/DatabaseManager/LogDatabase/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'FMDB'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-BV/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-BV/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-BV/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-BV/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-BV/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'TextButtonCell' do |sss|
      sss.source_files = 'MKLoRaWAN-BV/Classes/Expand/TextButtonCell/**'
    end
    
    ss.subspec 'ReportTimePointCell' do |sss|
      sss.source_files = 'MKLoRaWAN-BV/Classes/Expand/ReportTimePointCell/**'
    end
    
    ss.subspec 'TimingModeAddCell' do |sss|
      sss.source_files = 'MKLoRaWAN-BV/Classes/Expand/TimingModeAddCell/**'
    end
    
    ss.subspec 'FilterCell' do |sss|
      sss.subspec 'FilterBeaconCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Expand/FilterCell/FilterBeaconCell/**'
      end
      
      sss.subspec 'FilterByRawDataCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Expand/FilterCell/FilterByRawDataCell/**'
      end
      
      sss.subspec 'FilterEditSectionHeaderView' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Expand/FilterCell/FilterEditSectionHeaderView/**'
      end
      
      sss.subspec 'FilterNormalTextFieldCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Expand/FilterCell/FilterNormalTextFieldCell/**'
      end
      
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'ScanTimePointModel' do |sss|
      sss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanTimePointModel/**'
    end
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'BeaconContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BeaconContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BeaconContentPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BeaconContentPage/Model/**'
      end
    end
    
    ss.subspec 'BleGatewaySettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BleGatewaySettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BleGatewaySettingsPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanReportPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/PayloadContentPage/Controller'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BleGatewaySettingsPage/Model/**'
      end
    end
    
    ss.subspec 'BleSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BleSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BleSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-BV/Functions/BleSettingsPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BleSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BleSettingsPage/View/**'
      end
    end
    
    ss.subspec 'BXPAccContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPAccContentPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPAccContentPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPAccContentPage/Model/**'
      end
    end
    
    ss.subspec 'BXPBeaconContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPBeaconContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPBeaconContentPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPBeaconContentPage/Model/**'
      end
      
    end
    
    ss.subspec 'BXPButtonContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPButtonContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPButtonContentPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPButtonContentPage/Model/**'
      end
      
    end
    
    ss.subspec 'BXPInfoContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPInfoContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPInfoContentPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPInfoContentPage/Model/**'
      end
      
    end
    
    ss.subspec 'BXPTagContentPage' do |sss|
      
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPTagContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPTagContentPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPTagContentPage/Model/**'
      end
      
    end
    
    ss.subspec 'BXPTHContentPage' do |sss|
      
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPTHContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPTHContentPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/BXPTHContentPage/Model/**'
      end
      
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/DebuggerPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/DebuggerPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/DebuggerPage/View/**'
      end
      
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/DeviceInfoPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/DeviceInfoPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/UpdatePage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/SelftestPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/DebuggerPage/Controller'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/DeviceInfoPage/Model/**'
      end
    end
    
    ss.subspec 'DeviceSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/DeviceSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/DeviceSettingsPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/SynDataPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/IndicatorSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/DeviceInfoPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/DeviceSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'FilterPages' do |sss|
      
      sss.subspec 'FilterByAdvNamePage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByAdvNamePage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByAdvNamePage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByAdvNamePage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBeaconPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByBeaconPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByBeaconPage/Header'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByBeaconPage/Model'
          
        end
        
        ssss.subspec 'Header' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByBeaconPage/Header/**'
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByBeaconPage/Model/**'
          
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByBeaconPage/Header'
        end
      end
      
      sss.subspec 'FilterByBXPButtonPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByBXPButtonPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByBXPButtonPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByBXPButtonPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBXPTagPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByBXPTagPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByBXPTagPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByBXPTagPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByMacPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByMacPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByMacPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByMacPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByOtherPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByOtherPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByOtherPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByOtherPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByRawDataPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByRawDataPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByRawDataPage/Model'
          
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByBeaconPage/Controller'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByUIDPage/Controller'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByURLPage/Controller'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByTLMPage/Controller'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByBXPButtonPage/Controller'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByBXPTagPage/Controller'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByOtherPage/Controller'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByRawDataPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByTLMPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByTLMPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByTLMPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByTLMPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByUIDPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByUIDPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByUIDPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByUIDPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByURLPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByURLPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByURLPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterByURLPage/Model/**'
        end
      end
      
      
      sss.subspec 'FilterSettingPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterSettingPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterSettingPage/Model'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterSettingPage/View'
          
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByMacPage/Controller'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByAdvNamePage/Controller'
          sssss.dependency 'MKLoRaWAN-BV/Functions/FilterPages/FilterByRawDataPage/Controller'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterSettingPage/Model/**'
        end
        
        ssss.subspec 'View' do |sssss|
          sssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/FilterPages/FilterSettingPage/View/**'
        end
      end
      
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/GeneralPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/GeneralPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BleSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/THSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/OnOffSettingsPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/GeneralPage/Model/**'
      end
      
    end
    
    ss.subspec 'IndicatorSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/IndicatorSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/IndicatorSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/IndicatorSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/LoRaApplicationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/LoRaApplicationPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/MulticaseGroupPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/MessageTypePage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/LoRaApplicationPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/LoRaPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/LoRaPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/LoRaSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/LoRaApplicationPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/LoRaPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/LoRaSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/LoRaSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/LoRaSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'MessageTypePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/MessageTypePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/MessageTypePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/MessageTypePage/Model/**'
      end
      
    end
    
    ss.subspec 'MulticaseGroupPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/MulticaseGroupPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/MulticaseGroupPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/MulticaseGroupPage/Model/**'
      end
      
    end
    
    ss.subspec 'OnOffSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/OnOffSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/OnOffSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/OnOffSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'OtherTypeContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/OtherTypeContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/OtherTypeContentPage/Model'
        ssss.dependency 'MKLoRaWAN-BV/Functions/OtherTypeContentPage/View'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/OtherTypeContentPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/OtherTypeContentPage/View/**'
      end
      
    end
    
    ss.subspec 'PayloadContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/PayloadContentPage/Controller/**'
                        
        ssss.dependency 'MKLoRaWAN-BV/Functions/BeaconContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/UIDContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/URLContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/TLMContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPBeaconContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPInfoContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPAccContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPTHContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPButtonContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/BXPTagContentPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/OtherTypeContentPage/Controller'
      end
      
    end
    
    ss.subspec 'PeriodicImmediatelyPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/PeriodicImmediatelyPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/PeriodicImmediatelyPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/PeriodicImmediatelyPage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/PeriodicScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/PeriodicScanPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/PeriodicScanPage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicTimingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/PeriodicTimingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/PeriodicTimingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimePointModel'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/PeriodicTimingPage/Model/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimePointModel'
      end
      
    end
    
    ss.subspec 'ScanAlwaysPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanAlwaysPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanAlwaysPage/Model'
                
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanAlwaysPage/Model/**'
      end
      
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/TabBarPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanPage/View/**'
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'ScanReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanReportPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanReportPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/TimingImmediatelyPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/PeriodicImmediatelyPage/Controller'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanAlwaysPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/PeriodicScanPage/Controller'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimingPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/TimingReportPage/Controller'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/PeriodicTimingPage/Controller'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanReportPage/Model/**'
      end
      
    end
    
    ss.subspec 'ScanTimingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanTimingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimePointModel'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/ScanTimingPage/Model/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimePointModel'
      end
      
    end
    
    ss.subspec 'SelftestPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/SelftestPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/SelftestPage/View'
        ssss.dependency 'MKLoRaWAN-BV/Functions/SelftestPage/Model'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/SelftestPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/SelftestPage/Model/**'
      end
    end
    
    ss.subspec 'SynDataPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/SynDataPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/SynDataPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/SynDataPage/View/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/BleGatewaySettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-BV/Functions/DeviceSettingsPage/Controller'
      end
    end
    
    ss.subspec 'THSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/THSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/THSettingsPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/THSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'TimingImmediatelyPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/TimingImmediatelyPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/TimingImmediatelyPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimePointModel'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/TimingImmediatelyPage/Model/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimePointModel'
      end
      
    end
    
    ss.subspec 'TimingReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/TimingReportPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/TimingReportPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimePointModel'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/TimingReportPage/Model/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/ScanTimePointModel'
      end
      
    end
    
    ss.subspec 'TLMContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/TLMContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/TLMContentPage/Model'
                
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/TLMContentPage/Model/**'
      end
      
    end
    
    ss.subspec 'UIDContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/UIDContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/UIDContentPage/Model'
                
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/UIDContentPage/Model/**'
      end
      
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/UpdatePage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/UpdatePage/Model/**'
      end
    end
    
    ss.subspec 'URLContentPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/URLContentPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BV/Functions/URLContentPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BV/Classes/Functions/URLContentPage/Model/**'
      end
    end
    
    ss.dependency 'MKLoRaWAN-BV/SDK'
    ss.dependency 'MKLoRaWAN-BV/DatabaseManager'
    ss.dependency 'MKLoRaWAN-BV/CTMediator'
    ss.dependency 'MKLoRaWAN-BV/ConnectModule'
    ss.dependency 'MKLoRaWAN-BV/Expand'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary'
    
  end

end
