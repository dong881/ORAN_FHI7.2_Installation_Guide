#! /bin/bash

echo "--> Setting new kernel parameters:"

# 設定要修改的參數
# PCI parameters
PCI="pci=assign-busses pci=realloc igb.max_vfs=2" 

# IOMMU parameters
IOMMU="intel_iommu=on iommu=pt"

# CPU parameters  
CPU="intel_pstate=disable nosoftlockup tsc=nowatchdog mitigations=off"

# Memory parameters
MEM="cgroup_memory=1 cgroup_enable=memory mce=off" 

# Idle parameters
IDLE="idle=poll"

# Hugepages parameters  
HPAGES="hugepagesz=1G hugepages=40 hugepagesz=2M hugepages=0 default_hugepagesz=1G"

# Security parameters
SECURITY="selinux=0 enforcing=0 audit=0" 

# Watchdog parameters
WATCHDOG="nmi_watchdog=0 softlockup_panic=0"


# Scheduling parameters
CPU_RANGE="0-2,8-15"
SCHED="skew_tick=1 isolcpus=managed_irq,domain,${CPU_RANGE} nohz_full=${CPU_RANGE} rcu_nocbs=${CPU_RANGE} rcu_nocb_poll"

# Reconstruct parameter string
NEW_PARAMS="$PCI $IOMMU $CPU $MEM $IDLE $HPAGES $SECURITY $WATCHDOG $SCHED"

echo $NEW_PARAMS


echo -e "\n--> Updating /etc/default/grub with new parameters..."

# 修改 /etc/default/grub 檔案
sudo sed -i "s/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"$NEW_PARAMS\"/" /etc/default/grub

echo "success"

sudo grub2-mkconfig -o /boot/grub2/grub.cfg
echo -e "\nGRUB configuration updated successfully. Remember to manually reboot the system with 'sudo reboot' for changes to take effect.\n"
