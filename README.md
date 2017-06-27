> **Update:** Hello! As of 1 January 2017 this content is no longer being actively managed and updated. It is provided as-is and may contain information that has changed. Any Issues will be addressed on a best-effort basis. Please see [Azure.com](http://www.azure.com) for the latest guidance. Thank you for your understanding.

---

# Architecting Hybrid Solutions
One of the primary benefits of Azure as a cloud platform is its ability to enable hybrid solutions between on-premises and cloud.  We will start with a look at networking requirements for various workloads and will highlight opportunities such identity solutions and SQL Server Availability Groups to provide disaster recovery for specific workloads.  We will then look at Azure Site Recovery and Backup as options for protecting virtual machine solutions.  Finally, we will discuss Remote App and StorSimple as two additional enablers for hybrid solutions.

## Presentation
Download the [PowerPoint](https://github.com/GSIAzureCOE/Hybrid/blob/master/Architecting%20Hybrid%20Solutions.pptx?raw=1).
The PowerPoint includes full speaker notes helping you understand the slides, and everything you need to deliver the session.

## Demos
1. Extending AD to Azure
[[Demo script & source code](./Demo1-ExtendingADtoAzure/)]
[[video](http://azurecatgsicontent.blob.core.windows.net/architecting-hybrid-solutions/demo1_ADDS.mp4)]

2. Azure Backup
[[Demo script & source code](./Demo2-AzureBackup/)]
[[File and Folder backup video](http://azurecatgsicontent.blob.core.windows.net/architecting-hybrid-solutions/demo2_AzBackup_FilesFolders.mp4)]
[[Server backup video](http://azurecatgsicontent.blob.core.windows.net/architecting-hybrid-solutions/demo3_AzBackupServer.mp4)]
[[Virtual Machine backup video](http://azurecatgsicontent.blob.core.windows.net/architecting-hybrid-solutions/demo4_AzBackupVM.mp4)]

## Session objectives
* Discuss key hybrid scenarios
* Discuss on-prem to Azure integration & Network Connectivity (VPN/ExpressRoute) 
* Discuss DR & Backup capabilities (ASR, Azure Backup)
* Architecting for Disaster Recovery with SQL Server Always On (with DR, as currently in SAP demo)

## Session Prerequisites
* [Designing and Managing Azure Subscriptions](https://github.com/GSIAzureCOE/Designing-and-Managing-Azure-Subscriptions)
* [Architecting Virtual Machine Solutions on Azure](https://github.com/GSIAzureCOE/Virtual-Machine-Solutions)
* [Networking](https://github.com/GSIAzureCOE/Networking)

## Azure Services Covered
* [Extending AD to Azure ] (https://azure.microsoft.com/en-us/documentation/articles/guidance-iaas-ra-secure-vnet-ad/)
* [Azure Backup] (https://azure.microsoft.com/en-us/services/backup/)
* [Azure Site Recovery (ASR)] (https://azure.microsoft.com/en-us/services/site-recovery/)


## Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

