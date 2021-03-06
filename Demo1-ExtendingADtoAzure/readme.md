﻿
Extending Active Directory to Azure
=========

Demo Objective
=========

In this demo we’ll be connecting an existing on-premise network (simulated by an Azure infrastructure built on one VNET) with a virtual network in the another Azure VNET in a separate region via a secure Site-to-Site (S2S) IPsec VPN tunnel.  We will demonstrate the ability to host a full instance of Windows Server Active Directory, running on Windows Server 2012 R2, as a virtual machine in Azure cloud.

Demo Prerequisites
==================

This demo requires the following:

-   A Windows Azure subscription

-   Prior experience with Windows Server Active Directory.  This article also assumes that the reader is already somewhat familiar with configuring Windows Server 2012 Active Directory in an on-premise deployment

-   This demo assumes the infrastructure with VNETs in two regions to have been setup and connected via S2S VPN. If needed, this prerequisite can be met by running the CreateNetworks.ps1 file

-   This demo assumes the existence of a Windows Server 2012 R2 domain controller on one of the VNETs. This environment simulates the on-premises infrastructure. From here on out, we will refer to this infrastructure as ‘on-premises’

Demo Preparation
================

Configure On-Premise Active Directory Sites and Subnets
-------------------------------------------------------

1.  Create a new AD site by using the “*Active Directory Sites and Services”* tool accessible via the Server Manager on the “On-Premises” Active Directory computer.

    1.  Right-click on the Sites node and choose “New Site”

    2.  Name the node “WindowsAzure”, choose ``` DEFAULTIPSITELINK`` and click ok ```
 
<img src="Media/Site.PNG" />  |
<!-- -->

2.  Create a new AD Subnet for Windows Azure by right-clicking the “Subnets” folder and choosing new. Enter the subnet mask for the cloud VNet that will host the Active Directory replica. (10.42.0.0/24, if the provisioning was done using the script) Choose WindowsAzure and click OK

<img src="Media/Subnet.PNG" />  |

Register DNS in Windows Azure
-----------------------------

The next step is to register our existing on-premises Active Directory-integrated DNS server with Windows Azure.

1.  Sign in to the Azure management portal

2.  Enter the IP address of the “On-Premises” Active Directory domain controller IP as a “Custom DNS” for the VNet that will host the replica Domain controller<span id="provision-a-new-replica-domain-controlle" class="anchor"></span>

<img src="Media/DNS.PNG" />  |

Provision a New Replica Domain Controller in Windows Azure
----------------------------------------------------------

The next step is to deploy the Replica Domain controller.

1.  Deploy a new Windows Server Virtual Machine in the “Cloud” VNet

2.  Log On to the Virtual Machine and Add the “Active Directory Domain Services” features via Server Manager.

<img src="Media/AddFeature.PNG" />  |


3.  Once installed promote the server to a Replica Domain Controller in an existing Active Directory domain with the following parameters:  

    -   Active Directory domain name: DNS name of on-premise Active Directory domain: OnPremises.com

    -   Active Directory site name: WindowsAzure

    -   Verify there is no hard errors. The warnings on the screenshots are acceptable. Click Install. After the promotion, the server will reboot.

<img src="Media/DcPromo.PNG" />  |


Performing the demo
===================

The objective is to demonstrate the Windows Active Directory replication across VNETS in two regions.

1.  Create a new user in the On-Premises Active Directory

    1.  Name the user Test User


<img src="Media/NewUser.PNG" />  |


2.  As the default inter-site replication interval is 180 min, the new user will not be found on the CloudAD domain controller before a replication.
    1.  Using the **AD Sites and Services** tool, expand the **WindowsAzure** site, go the right pane right click on the **‘&lt;automatically generated&gt;** property setting, select **Replicate Now**

<img src="Media/Replicate.PNG" />  |

