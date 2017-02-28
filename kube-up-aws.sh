#!/bin/bash
### Johann Helbling johann.helbling@dreamit.de

# set bash or unset exist env
set -o errexit
set -o nounset
set -o pipefail
unset AWS_HOME
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset KOPS_STATE_STORE

#### Checking if kops installed
echo "Checking your local enviroment"
sleep 2
echo "Checking if kops installed and config exist"
sleep 3
KOPS="/usr/local/bin/kops"
KOPSCONF="$HOME/.kops/config"
if [[ -f $KOPS && $KOPSCONF ]]; then
  echo "$KOPS and $KOPSCONF found, OK"
else
  echo "$KOPS not found, please follow Installing Documentation https://github.com/kubernetes/kops"
exit 1
fi

#### Checking some credentials
echo "Checking AWS credentials"
sleep 2
AWSCRED="$HOME/.aws/credentials"
if [[ -f $AWSCRED ]]; then
  echo "$AWSCRED found, OK"
else
  echo "$AWSCRED not found, please read Documentation https://aws.amazon.com/developers/access-keys"
  echo "and create one with follow access rights"
  echo "AmazonEC2FullAccess"
  echo "AmazonRoute53FullAccess"
  echo "AmazonS3FullAccess"
  echo "IAMFullAccess"
  echo "AmazonVPCFullAccess"
exit 1
fi

### Agree setup
echo "Setup a new high-availability (HA) Kubernetes cluster on AWS"
echo "Do you agree with this? [yes or no]: "
read yno
case $yno in

        [yY] | [yY][Ee][Ss] )
                echo "OK, you will do it, let me ask you some question"
                ;;

        [nN] | [n|N][O|o] )
                echo "Not agreed, you can't proceed the installation";
                exit 1
                ;;
        *) echo "Invalid input"
            ;;
esac

### Ask Kubernetes version
echo "Do you want deploy stable version of Kubernetes [yes or no]: "
read yno
case $yno in

        [yY] | [yY][Ee][Ss] )
                echo "OK, next question"
                ;;

        [nN] | [n|N][O|o] )
                echo "Sorry, i can only deploy stable version";
                exit 1
                ;;
        *) echo "Invalid input"
            ;;
esac

#### Ask cluster name
echo "Please enter your cluster name e.g. my.cluster.name.tld"
read cluster_name
export $cluster_name
echo "Cluster name $cluster_name was set..."

### Ask network topology
echo "Please enter topology of cluster e.g. 'private or public' "
read topology
export $topology

#### Ask AWS zones
echo "Network topology of Kubernetes cluster was set as $topology, now please define your zones e.g: 'eu-west-1a,eu-west-1b,eu-west-1c' for AZ"
read zones
export $zones

#### Ask nodes counts
echo "Please set nodes counter, 'NOTES: for AZ/HA set up 3 nodes required'"
read worker_number
export $worker_number
echo "Worker number was set to $worker_counter, please define node size e.g. m4.large"

### Ask nodes sizing
read nodes_size
export $nodes_size
echo "Nodes size was set as $node_size"


exit 1
