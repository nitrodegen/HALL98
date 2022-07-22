#define MOV_REG 01
#define MUL_REG 02 
#define SUB_REG 03
#define ADD_REG 04 
#define MOV_NUM 11
#define MUL_NUM 22 
#define SUB_NUM 33 
#define ADD_NUM 44
 


struct kvm_cpu_instruction{
    
    int opcode;
    int oprand1;
    int oprand2;
    int optional;
};
struct vram_data{
    int addr;
    int val;  
};
struct CPU{
    int index;
    int registers[4];
    int IP;
};

struct VM{ 
    int index;
    int CPU_CORES;
    int VRAM[128];
    
};
#define KVM_CREATE_VCPU _IOW('a','d',struct CPU)
#define KVM_EXECUTE_INSTR _IOW('a','d',struct kvm_cpu_instruction)
#define KVM_WRITE_TO_VRAM _IOW('a','d',struct vram_data)
#define KVM_DUMP_VRAM _IOR('a','d',int*)
#define KVM_CREATE_VM _IOW('a','c',int)
#define KVM_CPU_STAT _IOR('a','g',struct CPU)