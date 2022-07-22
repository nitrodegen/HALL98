/*
    very basic /dev/kvm type thing
    altough it only works for basic shit, it could very well scaled up alot to work with x86 (myb one day haha).
*/
#include <linux/init.h> // //module_init module_exit __init __exit
#include <linux/module.h> // module stuff
#include <linux/kernel.h>//kern info stuff
#include <linux/kdev_t.h>
#include <linux/fs.h>
#include <linux/module.h>
#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/kdev_t.h>
#include <linux/fs.h>
#include <linux/device.h>
#include <linux/cdev.h>
#include <linux/uaccess.h>
#include <asm/uaccess.h>
#include "kvm_config.h"
//CREATE VM STRUCT THAT CONTAINS NUMBER OF CORES,VRAM , STORAGE

MODULE_LICENSE("GPL");
MODULE_AUTHOR("jellybean");

MODULE_DESCRIPTION("Yummy dummy HallCPU Kernel-Virtual-Machine (KVM)");
int majornum=0;
dev_t device;
dev_t devsnums;

struct class *pclass;

static int device_open(struct inode *inode, struct file *file){
    printk("\n device_open(%p)",&file);
    return 0;
}
static int device_close(struct inode *inode, struct file *file){
    printk("\n device_close(%p)",&file);
    return 0;
}

struct VM vm;
struct CPU cpu;
static long int  device_ioctl(struct file *file , unsigned cmd , unsigned long arg){

    if(cmd == KVM_CPU_STAT){
        copy_to_user((struct CPU*)arg,&cpu,sizeof(struct CPU));
        printk("\n kvm_cpu_stat(%p)",&cpu);
    }

    if(cmd == KVM_DUMP_VRAM){

        int* vram = vm.VRAM;
        copy_to_user((int*)arg,vram,sizeof(vram));
        printk("\n kvm_dump_vram(%p)",&vram);
        
    }
    if(cmd == KVM_WRITE_TO_VRAM){

        struct vram_data data;
        copy_from_user(&data,(struct vram_data*)arg,sizeof(struct vram_data));
        vm.VRAM[data.addr]=data.val;
        printk("\n kvm_write_to_vram(%p)",&data);

    }
    if(cmd == KVM_EXECUTE_INSTR)
    {
        
        struct kvm_cpu_instruction instr;
        copy_from_user(&instr,(struct kvm_cpu_instruction*)arg,sizeof(struct kvm_cpu_instruction));    
        printk("\n kvm_execute_instr(%p)",&file);
        if(instr.opcode == MOV_REG){
            cpu.registers[instr.oprand1] = cpu.registers[instr.oprand2];
            cpu.IP++;
        }
        if(instr.opcode == MOV_NUM){
            cpu.registers[instr.oprand1] =  instr.oprand2;
            cpu.IP++;
        }

        if(instr.opcode == MUL_NUM){
            cpu.registers[instr.oprand1] *=  instr.oprand2;
            cpu.IP++;
        }
        if(instr.opcode == MUL_REG){
            cpu.registers[instr.oprand1] *= cpu.registers[instr.oprand2];
            cpu.IP++;
        }

        if(instr.opcode ==SUB_NUM){
            cpu.registers[instr.oprand1] -=  instr.oprand2;
            cpu.IP++;
        }
        if(instr.opcode == SUB_REG){
            cpu.registers[instr.oprand1] -=  cpu.registers[instr.oprand2];
            cpu.IP++;
        }
        if(instr.opcode ==ADD_NUM){
            cpu.registers[instr.oprand1] +=  instr.oprand2;
            cpu.IP++;
        }
        if(instr.opcode == ADD_REG){
            cpu.registers[instr.oprand1] +=  cpu.registers[instr.oprand2];
            cpu.IP++;
        }
        printk("\n kvm_execute_instr(%p)",&instr);

    }
    if(cmd == KVM_CREATE_VCPU){
        copy_from_user(&cpu,(struct CPU*)arg,sizeof(struct CPU));
        printk("\n kvm_create_cpu(%p)",&cpu);
    }
    if(cmd == KVM_CREATE_VM){
        copy_from_user(&vm,(struct VM*)arg,sizeof(struct VM));
        printk("\n kvm_create_vm(%p)",&vm);

    }

    return 0;
}


struct file_operations fop={

    .owner = THIS_MODULE,
    .open=device_open,
    .release= device_close,
    .unlocked_ioctl= device_ioctl
};

static int __init kvm_init(void){
    struct device *pdev;
    printk("\n[*] ready for duty!");
    majornum = register_chrdev(0,"hallkvm",&fop); // register device with file opers
    devsnums = MKDEV(majornum,0); // make device with major num and 0 minor num 
    pclass = class_create(THIS_MODULE,"hallkvm");//create class with name 
    if(IS_ERR(pclass)){
        printk("\n couldnt create class!");
        return -1;
   
    }
    pdev = device_create(pclass,NULL,devsnums,NULL,"hallkvm"); // create device create with class and nums and name
    if(IS_ERR(pdev)){ 
        printk("\n couldn't create device!");
        return -1;
    }
    return 0;
}
static void __exit kvm_exit(void){
    //destroy everything

    device_destroy(pclass,devsnums);
    class_destroy(pclass);
    unregister_chrdev(majornum,"hallkvm");
    printk("\n[*] always wear swag mate");

}

module_init(kvm_init);
module_exit(kvm_exit);
