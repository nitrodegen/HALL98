#include <sys/ioctl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include "kvm_config.h"
int main(){
	int * vram = (int*)malloc(128);
//	unsigned int g  = IOCTL_WRITE;
	int fd = open("/dev/hallkvm",O_RDWR);
	struct VM vm;
	vm.index = 0;
	vm.CPU_CORES =1;
	//vm.VRAM = vram;
	ioctl(fd,KVM_CREATE_VM,&vm);
	struct CPU cpu;
	cpu.index = 0;
	cpu.IP = 0;
	cpu.registers[0] =0;
	cpu.registers[1] =0;
	cpu.registers[2] =0;
	cpu.registers[3] =0;
	
	ioctl(fd,KVM_CREATE_VCPU,&cpu);
	struct kvm_cpu_instruction instr;
	instr.opcode = MOV_NUM;
	instr.oprand1 = 0;
	instr.oprand2 = 2;
	instr.optional=NULL;
	ioctl(fd,KVM_EXECUTE_INSTR,&instr);
	struct CPU cpudump;
	ioctl(fd,KVM_CPU_STAT,&cpudump);
	printf("\nA:%d B:%d C:%d D:%d IP:%d",cpudump.registers[0],cpudump.registers[1],cpudump.registers[2],cpudump.registers[3],cpudump.IP);
	close(fd);
}
