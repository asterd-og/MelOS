#include <stdint.h>

typedef struct {
  uint16_t size;
  uint64_t offset;
} __attribute__((packed)) ptr;

void Out8(uint16_t port, uint8_t val) {
  __asm__ volatile ("outb %0, %1" : : "a"(val), "Nd"(port) : "memory");
}

uint8_t In8(uint16_t port) {
  uint8_t ret;
  __asm__ volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port) : "memory");
  return ret;
}

// 16 Bit

void Out16(uint16_t port, uint16_t val) {
  __asm__ volatile ("outw %0, %1" : : "a"(val), "Nd"(port) : "memory");
}

uint16_t In16(uint16_t port) {
  uint16_t ret;
  __asm__ volatile ("inw %%dx, %%ax" : "=a"(ret) : "d"(port) : "memory");
  return ret;
}

// 32 Bit

void Out32(uint16_t port, uint32_t val) {
  __asm__ volatile ("outl %0, %1" : : "a"(val), "Nd"(port) : "memory");
}

uint32_t In32(uint16_t port) {
  uint32_t ret;
  __asm__ volatile ("inl %1, %0" : "=a"(ret) : "Nd"(port) : "memory");
  return ret;
}

void WriteCR3(uint64_t addr) {
  __asm__ volatile ("mov %0, %%cr3" : : "r"(addr) : "memory");
}

void CLI() {
  __asm__ volatile("cli");
}

void HLT() {
  __asm__ volatile("hlt");
}

void IdtInstall(void* addr) {
  __asm__ volatile ("lidt %0" : : "m"(*((ptr*)addr)) : "memory");
  __asm__ volatile ("sti");
}

void IntCallHandler(void* addr, void* arg) {
  void(*Handler)(void*);
  Handler = addr;
  Handler(arg);
}