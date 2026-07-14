
first.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <Reset>:
   0:	00004117          	auipc	sp,0x4
   4:	00010113          	mv	sp,sp
   8:	0fc000ef          	jal	104 <disable_interrupts>
   c:	00300513          	li	a0,3
  10:	4dc000ef          	jal	4ec <uart_disable>
  14:	2d8000ef          	jal	2ec <main>

00000018 <circ_buf_init>:
  18:	080500a3          	sb	zero,129(a0)
  1c:	00050023          	sb	zero,0(a0)
  20:	08050123          	sb	zero,130(a0)
  24:	00008067          	ret

00000028 <circ_buf_close>:
  28:	fff00793          	li	a5,-1
  2c:	08f500a3          	sb	a5,129(a0)
  30:	00f50023          	sb	a5,0(a0)
  34:	08f50123          	sb	a5,130(a0)
  38:	00008067          	ret

0000003c <circ_buf_write>:
  3c:	00054783          	lbu	a5,0(a0)
  40:	0ff00713          	li	a4,255
  44:	02e78a63          	beq	a5,a4,78 <circ_buf_write+0x3c>
  48:	08154703          	lbu	a4,129(a0)
  4c:	00775693          	srli	a3,a4,0x7
  50:	02069863          	bnez	a3,80 <circ_buf_write+0x44>
  54:	00f506b3          	add	a3,a0,a5
  58:	00b680a3          	sb	a1,1(a3)
  5c:	00178793          	addi	a5,a5,1
  60:	07f7f793          	andi	a5,a5,127
  64:	00f50023          	sb	a5,0(a0)
  68:	00170713          	addi	a4,a4,1
  6c:	08e500a3          	sb	a4,129(a0)
  70:	00100513          	li	a0,1
  74:	00008067          	ret
  78:	fff00513          	li	a0,-1
  7c:	00008067          	ret
  80:	ffe00513          	li	a0,-2
  84:	00008067          	ret

00000088 <enable_interrupts>:
  88:	00050793          	mv	a5,a0
  8c:	58a02a23          	sw	a0,1428(zero) # 594 <isr>
  90:	00000517          	auipc	a0,0x0
  94:	07c50513          	addi	a0,a0,124 # 10c <interrupt_entry>
  98:	00050fbf          	.word	0x00050fbf
  9c:	00008067          	ret

000000a0 <interrupt_handler>:
  a0:	ff010113          	addi	sp,sp,-16 # 3ff0 <uart_read_buff+0x3a58>
  a4:	00112623          	sw	ra,12(sp)
  a8:	420000ef          	jal	4c8 <uart_Rx_ISR>
  ac:	58c02703          	lw	a4,1420(zero) # 58c <data>
  b0:	00170713          	addi	a4,a4,1
  b4:	58e02623          	sw	a4,1420(zero) # 58c <data>
  b8:	58c02783          	lw	a5,1420(zero) # 58c <data>
  bc:	0037f793          	andi	a5,a5,3
  c0:	02079e63          	bnez	a5,fc <interrupt_handler+0x5c>
  c4:	00100713          	li	a4,1
  c8:	58e02823          	sw	a4,1424(zero) # 590 <state>
  cc:	800007b7          	lui	a5,0x80000
  d0:	0007c703          	lbu	a4,0(a5) # 80000000 <_stack_start+0x7fffc000>
  d4:	00276713          	ori	a4,a4,2
  d8:	00e78023          	sb	a4,0(a5)
  dc:	0007c703          	lbu	a4,0(a5)
  e0:	0fd77713          	andi	a4,a4,253
  e4:	00e78023          	sb	a4,0(a5)
  e8:	0a000513          	li	a0,160
  ec:	f9dff0ef          	jal	88 <enable_interrupts>
  f0:	00c12083          	lw	ra,12(sp)
  f4:	01010113          	addi	sp,sp,16
  f8:	00008067          	ret
  fc:	58002823          	sw	zero,1424(zero) # 590 <state>
 100:	fcdff06f          	j	cc <interrupt_handler+0x2c>

00000104 <disable_interrupts>:
 104:	0000001f          	.word	0x0000001f
 108:	00008067          	ret

0000010c <interrupt_entry>:
 10c:	ff010113          	addi	sp,sp,-16
 110:	00f12223          	sw	a5,4(sp)
 114:	00112423          	sw	ra,8(sp)
 118:	01f12623          	sw	t6,12(sp)
 11c:	59402783          	lw	a5,1428(zero) # 594 <isr>
 120:	000780e7          	jalr	a5
 124:	00412783          	lw	a5,4(sp)
 128:	00812083          	lw	ra,8(sp)
 12c:	00c12f83          	lw	t6,12(sp)
 130:	01010113          	addi	sp,sp,16
 134:	000f8067          	jr	t6

00000138 <print_int>:
 138:	fe010113          	addi	sp,sp,-32
 13c:	00112e23          	sw	ra,28(sp)
 140:	00812c23          	sw	s0,24(sp)
 144:	00050413          	mv	s0,a0
 148:	0a054c63          	bltz	a0,200 <print_int+0xc8>
 14c:	0c050463          	beqz	a0,214 <print_int+0xdc>
 150:	00000693          	li	a3,0
 154:	66666837          	lui	a6,0x66666
 158:	66780813          	addi	a6,a6,1639 # 66666667 <_stack_start+0x66662667>
 15c:	00900893          	li	a7,9
 160:	0ff6f593          	zext.b	a1,a3
 164:	00068613          	mv	a2,a3
 168:	00158693          	addi	a3,a1,1
 16c:	01869693          	slli	a3,a3,0x18
 170:	4186d693          	srai	a3,a3,0x18
 174:	01060793          	addi	a5,a2,16
 178:	00278533          	add	a0,a5,sp
 17c:	03041733          	mulh	a4,s0,a6
 180:	40275713          	srai	a4,a4,0x2
 184:	41f45793          	srai	a5,s0,0x1f
 188:	40f70733          	sub	a4,a4,a5
 18c:	00271793          	slli	a5,a4,0x2
 190:	00e787b3          	add	a5,a5,a4
 194:	00179793          	slli	a5,a5,0x1
 198:	40f407b3          	sub	a5,s0,a5
 19c:	03078793          	addi	a5,a5,48
 1a0:	fef50a23          	sb	a5,-12(a0)
 1a4:	00040793          	mv	a5,s0
 1a8:	00070413          	mv	s0,a4
 1ac:	faf8cae3          	blt	a7,a5,160 <print_int+0x28>
 1b0:	04064063          	bltz	a2,1f0 <print_int+0xb8>
 1b4:	00912a23          	sw	s1,20(sp)
 1b8:	01212823          	sw	s2,16(sp)
 1bc:	00410413          	addi	s0,sp,4
 1c0:	00c40433          	add	s0,s0,a2
 1c4:	00310493          	addi	s1,sp,3
 1c8:	00c484b3          	add	s1,s1,a2
 1cc:	40b484b3          	sub	s1,s1,a1
 1d0:	00100913          	li	s2,1
 1d4:	00090593          	mv	a1,s2
 1d8:	00040513          	mv	a0,s0
 1dc:	284000ef          	jal	460 <uart_write>
 1e0:	fff40413          	addi	s0,s0,-1
 1e4:	fe8498e3          	bne	s1,s0,1d4 <print_int+0x9c>
 1e8:	01412483          	lw	s1,20(sp)
 1ec:	01012903          	lw	s2,16(sp)
 1f0:	01c12083          	lw	ra,28(sp)
 1f4:	01812403          	lw	s0,24(sp)
 1f8:	02010113          	addi	sp,sp,32
 1fc:	00008067          	ret
 200:	00100593          	li	a1,1
 204:	51c00513          	li	a0,1308
 208:	258000ef          	jal	460 <uart_write>
 20c:	40800433          	neg	s0,s0
 210:	f41ff06f          	j	150 <print_int+0x18>
 214:	00100593          	li	a1,1
 218:	52000513          	li	a0,1312
 21c:	244000ef          	jal	460 <uart_write>
 220:	fd1ff06f          	j	1f0 <print_int+0xb8>

00000224 <print_float>:
 224:	fd010113          	addi	sp,sp,-48
 228:	02112623          	sw	ra,44(sp)
 22c:	02812423          	sw	s0,40(sp)
 230:	00812e27          	fsw	fs0,28(sp)
 234:	20a50453          	fmv.s	fs0,fa0
 238:	20a517d3          	fneg.s	fa5,fa0
 23c:	c00797d3          	fcvt.w.s	a5,fa5,rtz
 240:	d007f7d3          	fcvt.s.w	fa5,a5
 244:	00a7f7d3          	fadd.s	fa5,fa5,fa0
 248:	56402707          	flw	fa4,1380(zero) # 564 <uart_disable+0x78>
 24c:	10e7f7d3          	fmul.s	fa5,fa5,fa4
 250:	c0079453          	fcvt.w.s	s0,fa5,rtz
 254:	06044e63          	bltz	s0,2d0 <print_float+0xac>
 258:	c0041553          	fcvt.w.s	a0,fs0,rtz
 25c:	eddff0ef          	jal	138 <print_int>
 260:	00100593          	li	a1,1
 264:	52400513          	li	a0,1316
 268:	1f8000ef          	jal	460 <uart_write>
 26c:	00c10693          	addi	a3,sp,12
 270:	00810593          	addi	a1,sp,8
 274:	66666637          	lui	a2,0x66666
 278:	66760613          	addi	a2,a2,1639 # 66666667 <_stack_start+0x66662667>
 27c:	02c41733          	mulh	a4,s0,a2
 280:	40275713          	srai	a4,a4,0x2
 284:	41f45793          	srai	a5,s0,0x1f
 288:	40f70733          	sub	a4,a4,a5
 28c:	00271793          	slli	a5,a4,0x2
 290:	00e787b3          	add	a5,a5,a4
 294:	00179793          	slli	a5,a5,0x1
 298:	40f407b3          	sub	a5,s0,a5
 29c:	03078793          	addi	a5,a5,48
 2a0:	00f681a3          	sb	a5,3(a3)
 2a4:	00070413          	mv	s0,a4
 2a8:	fff68693          	addi	a3,a3,-1
 2ac:	fcb698e3          	bne	a3,a1,27c <print_float+0x58>
 2b0:	00400593          	li	a1,4
 2b4:	00c10513          	addi	a0,sp,12
 2b8:	1a8000ef          	jal	460 <uart_write>
 2bc:	02c12083          	lw	ra,44(sp)
 2c0:	02812403          	lw	s0,40(sp)
 2c4:	01c12407          	flw	fs0,28(sp)
 2c8:	03010113          	addi	sp,sp,48
 2cc:	00008067          	ret
 2d0:	00078663          	beqz	a5,2dc <print_float+0xb8>
 2d4:	40800433          	neg	s0,s0
 2d8:	f81ff06f          	j	258 <print_float+0x34>
 2dc:	00100593          	li	a1,1
 2e0:	51c00513          	li	a0,1308
 2e4:	17c000ef          	jal	460 <uart_write>
 2e8:	fedff06f          	j	2d4 <print_float+0xb0>

000002ec <main>:
 2ec:	fd010113          	addi	sp,sp,-48
 2f0:	02112623          	sw	ra,44(sp)
 2f4:	02812423          	sw	s0,40(sp)
 2f8:	02912223          	sw	s1,36(sp)
 2fc:	03212023          	sw	s2,32(sp)
 300:	01312e23          	sw	s3,28(sp)
 304:	01412c23          	sw	s4,24(sp)
 308:	01512a23          	sw	s5,20(sp)
 30c:	00812627          	fsw	fs0,12(sp)
 310:	00912427          	fsw	fs1,8(sp)
 314:	00300513          	li	a0,3
 318:	114000ef          	jal	42c <uart_enable>
 31c:	0a000513          	li	a0,160
 320:	d69ff0ef          	jal	88 <enable_interrupts>
 324:	00700593          	li	a1,7
 328:	52800513          	li	a0,1320
 32c:	134000ef          	jal	460 <uart_write>
 330:	00000913          	li	s2,0
 334:	03200a13          	li	s4,50
 338:	53000993          	li	s3,1328
 33c:	00200493          	li	s1,2
 340:	52c00413          	li	s0,1324
 344:	00a00a93          	li	s5,10
 348:	d00974d3          	fcvt.s.w	fs1,s2
 34c:	412007b3          	neg	a5,s2
 350:	d007f453          	fcvt.s.w	fs0,a5
 354:	000a0593          	mv	a1,s4
 358:	00098513          	mv	a0,s3
 35c:	104000ef          	jal	460 <uart_write>
 360:	00090513          	mv	a0,s2
 364:	dd5ff0ef          	jal	138 <print_int>
 368:	00048593          	mv	a1,s1
 36c:	00040513          	mv	a0,s0
 370:	0f0000ef          	jal	460 <uart_write>
 374:	20948553          	fmv.s	fa0,fs1
 378:	eadff0ef          	jal	224 <print_float>
 37c:	00048593          	mv	a1,s1
 380:	00040513          	mv	a0,s0
 384:	0dc000ef          	jal	460 <uart_write>
 388:	20840553          	fmv.s	fa0,fs0
 38c:	e99ff0ef          	jal	224 <print_float>
 390:	00048593          	mv	a1,s1
 394:	00040513          	mv	a0,s0
 398:	0c8000ef          	jal	460 <uart_write>
 39c:	0094f553          	fadd.s	fa0,fs1,fs1
 3a0:	e85ff0ef          	jal	224 <print_float>
 3a4:	00048593          	mv	a1,s1
 3a8:	00040513          	mv	a0,s0
 3ac:	0b4000ef          	jal	460 <uart_write>
 3b0:	0894f553          	fsub.s	fa0,fs1,fs1
 3b4:	e71ff0ef          	jal	224 <print_float>
 3b8:	00048593          	mv	a1,s1
 3bc:	00040513          	mv	a0,s0
 3c0:	0a0000ef          	jal	460 <uart_write>
 3c4:	00847553          	fadd.s	fa0,fs0,fs0
 3c8:	e5dff0ef          	jal	224 <print_float>
 3cc:	00048593          	mv	a1,s1
 3d0:	00040513          	mv	a0,s0
 3d4:	08c000ef          	jal	460 <uart_write>
 3d8:	08847553          	fsub.s	fa0,fs0,fs0
 3dc:	e49ff0ef          	jal	224 <print_float>
 3e0:	00048593          	mv	a1,s1
 3e4:	00040513          	mv	a0,s0
 3e8:	078000ef          	jal	460 <uart_write>
 3ec:	0084f553          	fadd.s	fa0,fs1,fs0
 3f0:	e35ff0ef          	jal	224 <print_float>
 3f4:	00048593          	mv	a1,s1
 3f8:	00040513          	mv	a0,s0
 3fc:	064000ef          	jal	460 <uart_write>
 400:	0884f553          	fsub.s	fa0,fs1,fs0
 404:	e21ff0ef          	jal	224 <print_float>
 408:	00048593          	mv	a1,s1
 40c:	00040513          	mv	a0,s0
 410:	050000ef          	jal	460 <uart_write>
 414:	000a0593          	mv	a1,s4
 418:	00098513          	mv	a0,s3
 41c:	044000ef          	jal	460 <uart_write>
 420:	00190913          	addi	s2,s2,1
 424:	f35912e3          	bne	s2,s5,348 <main+0x5c>
 428:	0000006f          	j	428 <main+0x13c>

0000042c <uart_enable>:
 42c:	ff010113          	addi	sp,sp,-16
 430:	00112623          	sw	ra,12(sp)
 434:	80000737          	lui	a4,0x80000
 438:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fffc000>
 43c:	00357513          	andi	a0,a0,3
 440:	fff54513          	not	a0,a0
 444:	00a7f7b3          	and	a5,a5,a0
 448:	00f70023          	sb	a5,0(a4)
 44c:	59800513          	li	a0,1432
 450:	bc9ff0ef          	jal	18 <circ_buf_init>
 454:	00c12083          	lw	ra,12(sp)
 458:	01010113          	addi	sp,sp,16
 45c:	00008067          	ret

00000460 <uart_write>:
 460:	04058463          	beqz	a1,4a8 <uart_write+0x48>
 464:	00050693          	mv	a3,a0
 468:	00b50633          	add	a2,a0,a1
 46c:	80000737          	lui	a4,0x80000
 470:	00170593          	addi	a1,a4,1 # 80000001 <_stack_start+0x7fffc001>
 474:	00074783          	lbu	a5,0(a4)
 478:	0047f793          	andi	a5,a5,4
 47c:	fe078ce3          	beqz	a5,474 <uart_write+0x14>
 480:	0006c783          	lbu	a5,0(a3)
 484:	00f58023          	sb	a5,0(a1)
 488:	00074783          	lbu	a5,0(a4)
 48c:	0107e793          	ori	a5,a5,16
 490:	00f70023          	sb	a5,0(a4)
 494:	00074783          	lbu	a5,0(a4)
 498:	0ef7f793          	andi	a5,a5,239
 49c:	00f70023          	sb	a5,0(a4)
 4a0:	00168693          	addi	a3,a3,1
 4a4:	fcc698e3          	bne	a3,a2,474 <uart_write+0x14>
 4a8:	80000737          	lui	a4,0x80000
 4ac:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fffc000>
 4b0:	0ef7f793          	andi	a5,a5,239
 4b4:	00f70023          	sb	a5,0(a4)
 4b8:	00074783          	lbu	a5,0(a4)
 4bc:	0047f793          	andi	a5,a5,4
 4c0:	fe078ce3          	beqz	a5,4b8 <uart_write+0x58>
 4c4:	00008067          	ret

000004c8 <uart_Rx_ISR>:
 4c8:	ff010113          	addi	sp,sp,-16
 4cc:	00112623          	sw	ra,12(sp)
 4d0:	800007b7          	lui	a5,0x80000
 4d4:	0027c583          	lbu	a1,2(a5) # 80000002 <_stack_start+0x7fffc002>
 4d8:	59800513          	li	a0,1432
 4dc:	b61ff0ef          	jal	3c <circ_buf_write>
 4e0:	00c12083          	lw	ra,12(sp)
 4e4:	01010113          	addi	sp,sp,16
 4e8:	00008067          	ret

000004ec <uart_disable>:
 4ec:	ff010113          	addi	sp,sp,-16
 4f0:	00112623          	sw	ra,12(sp)
 4f4:	80000737          	lui	a4,0x80000
 4f8:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fffc000>
 4fc:	00357513          	andi	a0,a0,3
 500:	00a7e7b3          	or	a5,a5,a0
 504:	00f70023          	sb	a5,0(a4)
 508:	59800513          	li	a0,1432
 50c:	b1dff0ef          	jal	28 <circ_buf_close>
 510:	00c12083          	lw	ra,12(sp)
 514:	01010113          	addi	sp,sp,16
 518:	00008067          	ret
