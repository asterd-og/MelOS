[extern IsrHandler]
[extern IrqHandler]
[global IdtIntTable]

%macro Pusha_ 0
  push rax
  push rcx
  push rdx
  push rbx
  push rbp
  push rsi
  push rdi
  push r8
  push r9
  push r10
  push r11
  push r12
  push r13
  push r14
  push r15
%endmacro

%macro Popa_ 0
  pop r15
  pop r14
  pop r13
  pop r12
  pop r11
  pop r10
  pop r9
  pop r8
  pop rdi
  pop rsi
  pop rbp
  pop rbx
  pop rdx
  pop rcx
  pop rax
%endmacro

%macro isr_no_err_stub 1
int_stub%+%1:
  push 0
  push %1
  Pusha_

  mov rdi, rsp
  call IsrHandler

  Popa_

  add rsp, 16
  iretq
%endmacro

%macro isr_err_stub 1
int_stub%+%1:
  push %1
  Pusha_

  mov rdi, rsp
  call IsrHandler

  Popa_

  add rsp, 16
  iretq
%endmacro

%macro irq_stub 1
int_stub%+%1:
  push 0
  push %1
  Pusha_

  mov rdi, rsp
  call IrqHandler

  Popa_

  add rsp, 16
  iretq
%endmacro

isr_no_err_stub 0
isr_no_err_stub 1
isr_no_err_stub 2
isr_no_err_stub 3
isr_no_err_stub 4
isr_no_err_stub 5
isr_no_err_stub 6
isr_no_err_stub 7
isr_err_stub    8
isr_no_err_stub 9
isr_err_stub    10
isr_err_stub    11
isr_err_stub    12
isr_err_stub    13
isr_err_stub    14
isr_no_err_stub 15
isr_no_err_stub 16
isr_err_stub    17
isr_no_err_stub 18
isr_no_err_stub 19
isr_no_err_stub 20
isr_no_err_stub 21
isr_no_err_stub 22
isr_no_err_stub 23
isr_no_err_stub 24
isr_no_err_stub 25
isr_no_err_stub 26
isr_no_err_stub 27
isr_no_err_stub 28
isr_no_err_stub 29
isr_err_stub    30
isr_no_err_stub 31

irq_stub 32
irq_stub 33
irq_stub 34
irq_stub 35
irq_stub 36
irq_stub 37
irq_stub 38
irq_stub 39
irq_stub 40
irq_stub 41
irq_stub 42
irq_stub 43
irq_stub 44
irq_stub 45
irq_stub 46
irq_stub 47

section .data

IdtIntTable:
  %assign i 0
  %rep 48
    dq int_stub%+i
    %assign i i+1
  %endrep