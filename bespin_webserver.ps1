
Configuration bespin_webserver
{

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    
    Import-DscResource -ModuleName cChoco -ModuleVersion "2.3.1.0"


    Node localhost
    {

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
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature WebManagementService
        {
            Name = "Web-Mgmt-Service"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature ASPNet45
        {
            Name = "Web-Asp-Net45"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature HTTPRedirection
        {
            Name = "Web-Http-Redirect"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature CustomLogging
        {
            Name = "Web-Custom-Logging"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature LoggingTools
        {
            Name = "Web-Log-Libraries"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature RequestMonitor
        {
            Name = "Web-Request-Monitor"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature Tracing
        {
            Name = "Web-Http-Tracing"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature BasicAuthentication
        {
            Name = "Web-Basic-Auth"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature WindowsAuthentication
        {
            Name = "Web-Windows-Auth"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }
        WindowsFeature ApplicationInitialization
        {
            Name = "Web-AppInit"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]WebServerRole"
        }

        cChocoPackageInstaller vcredist2015
        {            
            Name = "vcredist2015"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        cChocoPackageInstaller dotnetcore
        {
            Name = "dotNetCore"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        cChocoPackageInstaller dotnetcore-windowshosting
        {
            Name = "dotnetcore-windowshosting"
            DependsOn = "[cChocoPackageInstaller]vcredist2015"
        }
    }
}

bespin_webserver