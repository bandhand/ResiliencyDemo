using './infra/main.bicep'

// Basic configuration
param projectName = 'bsdecd'

// Azure Stack HCI configuration - Update these to match your Azure Local environment
// These 3 values should be the FULL resource ID of your custom location
param customLocationId = '/subscriptions/fca2e8ee-1179-48b8-9532-428ed0873a2e/resourceGroups/cse01-ceaf776e69ff-HostedResources-23EB627D/providers/Microsoft.ExtendedLocation/customLocations/cse01-ceaf776e69ff-cstm-loc'
param logicalNetworkId = '/subscriptions/fca2e8ee-1179-48b8-9532-428ed0873a2e/resourceGroups/dramasamy-cse01-873a2e-infra-rg/providers/Microsoft.AzureStackHCI/logicalNetworks/lnet-765-10-40-153-10-250'
param vmImageId = '/subscriptions/fca2e8ee-1179-48b8-9532-428ed0873a2e/resourceGroups/cc-test/providers/Microsoft.AzureStackHCI/galleryImages/ubuntu2404lts'

// This is just the name of the storage account itself
param scriptStorageAccount = 'ecommscripts8895' // Leave empty to auto-generate, or specify existing storage account name

// Static IP assignments (update these to match your network range)
// All IPs must be in the same subnet
param staticIPs = {
  loadBalancer: '10.40.153.220'
  dbPrimary: '10.40.153.221'
  dbReplica: '10.40.153.222'
  webapp1: '10.40.153.223'
  webapp2: '10.40.153.224'
}

// Availability zone assignments for VM placement
// Distributes VMs across zones for high availability
// Leave zone value as empty string '' to disable zone placement for a specific VM
param placementZones = {
  dbPrimary: ''    // Database primary in zone 1
  dbReplica: ''    // Database replica in zone 2
  webapp1: ''      // Web app 1 in zone 1
  webapp2: ''      // Web app 2 in zone 2
  loadBalancer: '' // Load balancer in zone 3
}

// DNS configuration (OPTIONAL) - Configure custom DNS servers for VMs
// Leave empty to use DNS servers from the Logical Network (LNET)
param dnsServers = ['10.251.37.6'] // Example: Azure DNS - param dnsServers = ['168.63.129.16']

// Proxy configuration (OPTIONAL) - Configure if VMs need to access internet through a proxy
// Leave these empty to disable proxy configuration
param httpProxy = 'http://10.251.37.6:3128' // Example: 'http://proxy.example.com:3128'
param httpsProxy = 'http://10.251.37.6:3128' // Example: 'http://proxy.example.com:3128'
param noProxy = 'localhost,127.0.0.1,.svc,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,100.0.0.0/8'
param proxyCertificate = '' // Certificate content or file path for proxy authentication


// Admin credentials - CHANGE THESE VALUES!
param adminUsername = 'azureuser'
param adminPassword = 'ChangeThisPassword456!' // REQUIRED - Change this to a secure password

// Service credentials - CHANGE THIS VALUE!
param servicePassword = 'ChangeThisServicePassword456!' // Used for database and other services


// Optional to set SSH Authentication

// SSH Authentication (OPTIONAL) - Adds SSH key authentication IN ADDITION to password
// Uncomment and update the path to your public key file:
// param sshPublicKey = loadTextContent('./.ssh/id_rsa.pub')
