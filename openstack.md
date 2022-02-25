Some open stack modules include

-Nova(Compute)
-Magnum/Murano
-Swift(Object storage)
-Trove
-Keystone(Identity service)
-Ceilometer/Gnocci
-Heat
-Zaqar
-Mistral
-MagnetoDB
-Neutron(Networking)
-Horizon(Dashboard)

### Nova(Compute)

To implement services and associated libraries to provide massively scalable, on demand, self service access to compute resources, including bare metal, virtual machines ,and containers.

-Provides configuration and coordinates the creation of a Virtual Machine instance
-Fault tolerant ,recoverable and provides API compatibility with a range of hypervisors and external providers like Amazon's EC2
-Utilizes the REST API service and is driven by messaging (RabbitMQ) which allows the service to scale across multiple nodes.

### Cinder(Block Storage)

The OpenStack Block Storage service (cinder) provides persistent block storage for compute instances. The Block Storage is responsible for managing the life cycle of block devices ,from creation and attachment of volumes to instances, to their release.
-Provides persistent block storage resources to instances that they can consume via drivers for physical infrastructure
-This includes secondary block storage devices much like Amazon's EBS or Azure Storage Disk
-Can be used to create volume snapshots for bootable volumes that can be detached and re-attached to a new instance or used as backup vol

### Neutron(Networking)

Neutron provides the networking capability for OpenStack. It helps to ensure that each of the components of an OpenStack deployment can communicate with another quickly and efficiently.
-Provides the software defined network functionality to the infrastructure and workloads running under and on the OpenStack platform. Neutron delivers Network-as-a-Service to the virtual compute environment.
-Prior to Neutron there was Quantum and Nova networks. Nova network was based on bridged physical interfaces. Neutron has similar capabilities called provider networks.
-Neutron was designed to standardize and abstract the networking from physical and software differences in the underlying infrastructure while adding automation and software abstraction to configuration

### Glance(Image Service)

Glance image services include discovering, registering ,and retrieving virtual machine images. Glance has a RESTful API that allows querying of VM image metadata as well as retrieval of the actual image.
-Glance is used as a service of uploading, discovering and retrieving images for use in provisioning instances and bare metal assets.
-The glance service stores images and metadata
-Glance supports many different image types such as RAW, QCOW2,ISO, VHD,VMDK,VDI,AMI and others.

### Swift(Object Storage)

Swift is a highly available, distributed ,eventually consistent object/blob store. Organizations can use Swift to store lots of data efficiently ,safely ,and cheaply. It's built for scale and optimized for durability ,availability and concurrency across the entire data set. Swift is ideal for storing unstructured data that can grow without bound.
-Swift is a highly available, distributed and consistent object data store 
-Swift is fully S3 compatible and can be configured to use AWS's S3 service
-Swift technology is the same technology used at Dropbox and is used by many enterprise storage clouds form fortune 500 companies.

### Keystone (Identity)

Keystone is an OpenStack service that provides API client authentication ,service discovery, and distributed multi-tenant authorization by implementing OpenStack's Identity API. It supports LDAP , OAuth ,OpenID Connect, SAML and SQL.
-Simply processes API requests ,provides identity,token catalog, and policy services.
-Token service administers and verifies tokens that are used by other services to authorize user's credentials have been validated.
-Also provides a service registry that can be used for endpoint discovery and its policy service exposes a rule-based authorization engine.
