# MIST webserver lift-n-shift DSC configuration v1
Configuration DSC-Webserver 
{ 
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName cChoco 
    Import-DscResource -Module xWebAdministration
    Node "webserver" {   

        cChocoInstaller installChoco 
        { 
            InstallDir = "C:\choco" 
        }

        WindowsFeature WebServerRole
        {
            Name = "Web-Server"
            Ensure = "Present"
        }
        WindowsFeature WebManagementConsole
        {
            Name = "Web-Mgmt-Console"
            Ensure = "Present"
        }
        WindowsFeature WebManagementService
        {
            Name = "Web-Mgmt-Service"
            Ensure = "Present"
        }
        WindowsFeature ASPNet45
        {
            Name = "Web-Asp-Net45"
            Ensure = "Present"
        }
        WindowsFeature HTTPRedirection
        {
            Name = "Web-Http-Redirect"
          Ensure = "Present"
          }
        WindowsFeature CustomLogging
        {
            Name = "Web-Custom-Logging"
            Ensure = "Present"
        }
        WindowsFeature LoggingTools
        {
            Name = "Web-Log-Libraries"
            Ensure = "Present"
        }
        WindowsFeature RequestMonitor
        {
            Name = "Web-Request-Monitor"
            Ensure = "Present"
        }
        WindowsFeature Tracing
        {
            Name = "Web-Http-Tracing"
            Ensure = "Present"
        }
        WindowsFeature BasicAuthentication
        {
            Name = "Web-Basic-Auth"
            Ensure = "Present"
        }
        WindowsFeature WindowsAuthentication
        {
            Name = "Web-Windows-Auth"
            Ensure = "Present"
        }
        WindowsFeature ApplicationInitialization
        {
            Name = "Web-AppInit"
            Ensure = "Present"
        }

        
        # Stop the default website 
         xWebsite DefaultSite  
         { 
             Ensure          = 'Present' 
             Name            = 'Default Web Site' 
             State           = 'Stopped' 
             PhysicalPath    = 'C:\inetpub\wwwroot' 
             DependsOn       = '[WindowsFeature]WebServerRole' 
        } 

        cChocoPackageInstaller vcredist2010
        {            
            Name = "vcredist2010"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        cChocoPackageInstaller vcredist2013
        {            
            Name = "vcredist2013"
            DependsOn = "[cChocoInstaller]installChoco"
        }


        cChocoPackageInstaller vcredist2015
        {            
            Name = "vcredist2015"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        
        cChocoPackageInstaller MVC4
        {            
            Name = "aspnetmvc4.install"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        cChocoPackageInstaller MVC3
        {            
            Name = "aspnetmvc.install"
            DependsOn = "[cChocoInstaller]installChoco"
        }

    }    
}