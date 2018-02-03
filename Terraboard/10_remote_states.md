!SLIDE
## Remote states

Various backends:

* s3, locking with dynamodb
* consul, including locking
* etcd (no locking)
* http (optional locking)
* swift (no locking)
* etc.


!SLIDE
## Where is my resource managed?

#### Common issue:

Find which Terraform configuration manages a resource using one of its
parameters

