module.exports = {
  networks: { 
     development: { 
      host: "192.168.18.11",     // Localhost (default: none)
      port: 7545,            // Standard Ethereum port (default: none) 
      network_id: "5777",       // Any network (default: none)
     }, 
  }, 
    contracts_build_directory: "./src/artifacts/", 
      
  // Configure your compilers 
  compilers: { 
    solc: {     
      
       // See the solidity docs for advice 
       // about optimization and evmVersion 
        optimizer: { 
          enabled: false, 
          runs: 200 
        }, 
        evmVersion: "byzantium"
    } 
  } 
}; 