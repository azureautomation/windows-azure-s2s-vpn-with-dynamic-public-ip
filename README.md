Windows Azure: S2S VPN with dynamic public IP
=============================================

            

Hi Folks,


Some weeks ago, I decided to focus myself a bit more on Windows Azure and tests several scenarios. The first one was to establish a Site to Site VPN between Windows Azure and my lab at home.
Microsoft is now supporting Windows Server 2012 Routing and Remote Access Service (RRAS) as VPN device with Windows Azure, so all I need is to create a new VM for this task.


To configure and establish the connection with RRAS, I recommend you the two following guides:


[http://blogs.technet.com/b/arnaud/archive/2013/06/06/cloud-hybride-vpn-site-224-site-avec-azure-et-windows-server-2012.aspx](http://blogs.technet.com/b/arnaud/archive/2013/06/06/cloud-hybride-vpn-site-224-site-avec-azure-et-windows-server-2012.aspx)
[http://fabriccontroller.net/blog/posts/setting-up-software-based-site-to-site-vpn-for-windows-azure-with-windows-server-2012-routing-and-remote-access/](http://fabriccontroller.net/blog/posts/setting-up-software-based-site-to-site-vpn-for-windows-azure-with-windows-server-2012-routing-and-remote-access/)


 


When you configure your Azure network, it will create an IPSEC tunnel between Azure and your site. During this process, you will have to specify a VPN Gateway Address, which is simply your ISP Internet public IP.


If your Internet Service Provider (ISP) provides you a fix IP, no problem, you are all set. Now, if your ISP provides you a public IP that is changing every x days (like me), each time this IP will change, the VPN connection will go down and you will have
 to update your public IP in the Azure Web Interface.


Even if I’m using this S2S VPN connection for testing purpose only, updating my public IP manually into Azure Web Interface, this is not an option for me. Hopefully, PowerShell is there to help us.


The use of this use is described on the following post :


[http://www.vnext.be/2013/12/01/windows-azure-s2s-vpn-with-dynamic-public-ip/](http://www.vnext.be/2013/12/01/windows-azure-s2s-vpn-with-dynamic-public-ip/)


 


 

 

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
