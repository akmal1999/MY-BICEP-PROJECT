Evaluation Project: Bicep
Objective

This project is built based "Evaluation Project: Bicep Objective Establish a secure and scalable Azure environment tailored for a web application hosted on a Virtual Machine (VM), ensuring high availability, automated deployment, security, and monitoring. The setup must use Bicep for infrastructure definition and include both an Azure SQL Database and a Storage Account, with configurations and deployment processes documented and pushed to a public GitHub repository."

Project Info.

This project is modularized for future expansion and to templatize and organize for future usage. The modules folder contains subfolders for each logical grouping of resources (like network, compute, data, and core). This makes it easier to manage and understand the relationships between resources. A parameters folder is used to store environment-specific parameter files, allowing for easy switching between different configurations (e.g., development, testing, production).

MY-BICEP-PROJECT Repo/
│
├── .github/                             # GitHub Actions workflows
│   └── workflows/
│       └── deploy-infrastructure.yml    # Workflow definition for GitHub Actions
│
├── azure-pipelines.yml                  # Azure DevOps pipeline definition (if using Azure DevOps)
│
├── main.bicep                           # Main orchestration Bicep file
│
├── modules/                             # Folder containing all modular Bicep files
│   ├── compute/
│   │   └── vm.bicep                     # VM creation module, including Key Vault integration for secrets
│   │
│   ├── core/
│   │   ├── keyVault.bicep               # Key Vault module for secrets management
│   │   └── resourceGroup.bicep          # Resource Group creation module
│   │
│   ├── data/
│   │   ├── sqlDatabase.bicep            # SQL Database creation module
│   │   └── storageAccount.bicep         # Storage Account creation module
│   │
│   └── network/
│       ├── nsg.bicep                    # NSG setup module
│       └── vnet.bicep                   # Virtual Network and subnet setup module
│
└── parameters/                          # Folder for parameter files for different environments
    └── dev.parameters.json              # Development environment-specific parameters
