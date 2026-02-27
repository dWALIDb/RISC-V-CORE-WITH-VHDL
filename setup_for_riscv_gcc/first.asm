
first.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <Reset>:
   0:	00004117          	auipc	sp,0x4
   4:	00010113          	mv	sp,sp
   8:	220000ef          	jal	228 <disable_interrupts>
   c:	00300513          	li	a0,3
  10:	2b1000ef          	jal	ac0 <uart_disable>
  14:	734000ef          	jal	748 <main>

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

00000088 <circ_buf_read>:
  88:	08254783          	lbu	a5,130(a0)
  8c:	0ff00713          	li	a4,255
  90:	02e78c63          	beq	a5,a4,c8 <circ_buf_read+0x40>
  94:	08154703          	lbu	a4,129(a0)
  98:	02070c63          	beqz	a4,d0 <circ_buf_read+0x48>
  9c:	fff70713          	addi	a4,a4,-1
  a0:	08e500a3          	sb	a4,129(a0)
  a4:	00f507b3          	add	a5,a0,a5
  a8:	0017c783          	lbu	a5,1(a5)
  ac:	00f58023          	sb	a5,0(a1)
  b0:	08254783          	lbu	a5,130(a0)
  b4:	00178793          	addi	a5,a5,1
  b8:	07f7f793          	andi	a5,a5,127
  bc:	08f50123          	sb	a5,130(a0)
  c0:	00100513          	li	a0,1
  c4:	00008067          	ret
  c8:	fff00513          	li	a0,-1
  cc:	00008067          	ret
  d0:	ffd00513          	li	a0,-3
  d4:	00008067          	ret

000000d8 <circ_buf_is_full>:
  d8:	08154503          	lbu	a0,129(a0)
  dc:	00755513          	srli	a0,a0,0x7
  e0:	00008067          	ret

000000e4 <circ_buf_is_empty>:
  e4:	08154503          	lbu	a0,129(a0)
  e8:	00153513          	seqz	a0,a0
  ec:	00008067          	ret

000000f0 <circ_buf_data_available>:
  f0:	08154503          	lbu	a0,129(a0)
  f4:	00a03533          	snez	a0,a0
  f8:	00008067          	ret

000000fc <output_data>:
  fc:	00050793          	mv	a5,a0
 100:	00058713          	mv	a4,a1
 104:	00078513          	mv	a0,a5
 108:	00070593          	mv	a1,a4
 10c:	00b50533          	add	a0,a0,a1
 110:	00400793          	li	a5,4
 114:	02f60663          	beq	a2,a5,140 <output_data+0x44>
 118:	00c7ec63          	bltu	a5,a2,130 <output_data+0x34>
 11c:	02060663          	beqz	a2,148 <output_data+0x4c>
 120:	00100793          	li	a5,1
 124:	02f61663          	bne	a2,a5,150 <output_data+0x54>
 128:	00051008          	.word	0x00051008
 12c:	00008067          	ret
 130:	00500793          	li	a5,5
 134:	00f61e63          	bne	a2,a5,150 <output_data+0x54>
 138:	00055008          	.word	0x00055008
 13c:	00008067          	ret
 140:	00054008          	.word	0x00054008
 144:	00008067          	ret
 148:	00050008          	.word	0x00050008
 14c:	00008067          	ret
 150:	00052008          	.word	0x00052008
 154:	00008067          	ret

00000158 <input_data>:
 158:	ff010113          	addi	sp,sp,-16 # 3ff0 <uart_read_buff+0x345c>
 15c:	00050793          	mv	a5,a0
 160:	00058713          	mv	a4,a1
 164:	00f70533          	add	a0,a4,a5
 168:	00400693          	li	a3,4
 16c:	02d60463          	beq	a2,a3,194 <input_data+0x3c>
 170:	00500713          	li	a4,5
 174:	04e60263          	beq	a2,a4,1b8 <input_data+0x60>
 178:	00a52077          	.word	0x00a52077
 17c:	00000293          	li	t0,0
 180:	0002a703          	lw	a4,0(t0)
 184:	00e12623          	sw	a4,12(sp)
 188:	00c12703          	lw	a4,12(sp)
 18c:	00e7a023          	sw	a4,0(a5)
 190:	0200006f          	j	1b0 <input_data+0x58>
 194:	00050077          	.word	0x00050077
 198:	00000293          	li	t0,0
 19c:	0002c683          	lbu	a3,0(t0)
 1a0:	00d104a3          	sb	a3,9(sp)
 1a4:	00914683          	lbu	a3,9(sp)
 1a8:	00e785b3          	add	a1,a5,a4
 1ac:	00d58023          	sb	a3,0(a1)
 1b0:	01010113          	addi	sp,sp,16
 1b4:	00008067          	ret
 1b8:	00051077          	.word	0x00051077
 1bc:	00000293          	li	t0,0
 1c0:	0002d703          	lhu	a4,0(t0)
 1c4:	00e11523          	sh	a4,10(sp)
 1c8:	00a15703          	lhu	a4,10(sp)
 1cc:	00e79023          	sh	a4,0(a5)
 1d0:	fe1ff06f          	j	1b0 <input_data+0x58>

000001d4 <enable_interrupts>:
 1d4:	00050793          	mv	a5,a0
 1d8:	00001737          	lui	a4,0x1
 1dc:	b8a72823          	sw	a0,-1136(a4) # b90 <isr>
 1e0:	00000517          	auipc	a0,0x0
 1e4:	05050513          	addi	a0,a0,80 # 230 <interrupt_entry>
 1e8:	00050fbf          	.word	0x00050fbf
 1ec:	00008067          	ret

000001f0 <interrupt_handler>:
 1f0:	ff010113          	addi	sp,sp,-16
 1f4:	00112623          	sw	ra,12(sp)
 1f8:	800007b7          	lui	a5,0x80000
 1fc:	0007c703          	lbu	a4,0(a5) # 80000000 <_stack_start+0x7fffc000>
 200:	00276713          	ori	a4,a4,2
 204:	00e78023          	sb	a4,0(a5)
 208:	0007c703          	lbu	a4,0(a5)
 20c:	0fd77713          	andi	a4,a4,253
 210:	00e78023          	sb	a4,0(a5)
 214:	1f000513          	li	a0,496
 218:	fbdff0ef          	jal	1d4 <enable_interrupts>
 21c:	00c12083          	lw	ra,12(sp)
 220:	01010113          	addi	sp,sp,16
 224:	00008067          	ret

00000228 <disable_interrupts>:
 228:	0000001f          	.word	0x0000001f
 22c:	00008067          	ret

00000230 <interrupt_entry>:
 230:	ff010113          	addi	sp,sp,-16
 234:	00f12223          	sw	a5,4(sp)
 238:	00112423          	sw	ra,8(sp)
 23c:	01f12623          	sw	t6,12(sp)
 240:	000017b7          	lui	a5,0x1
 244:	b907a783          	lw	a5,-1136(a5) # b90 <isr>
 248:	000780e7          	jalr	a5
 24c:	00412783          	lw	a5,4(sp)
 250:	00812083          	lw	ra,8(sp)
 254:	00c12f83          	lw	t6,12(sp)
 258:	01010113          	addi	sp,sp,16
 25c:	000f8067          	jr	t6

00000260 <byte_to_hex>:
 260:	fe010113          	addi	sp,sp,-32
 264:	000017b7          	lui	a5,0x1
 268:	b0078793          	addi	a5,a5,-1280 # b00 <uart_elem_count+0xc>
 26c:	0007a603          	lw	a2,0(a5)
 270:	0047a683          	lw	a3,4(a5)
 274:	0087a703          	lw	a4,8(a5)
 278:	00c12623          	sw	a2,12(sp)
 27c:	00d12823          	sw	a3,16(sp)
 280:	00e12a23          	sw	a4,20(sp)
 284:	00c7a783          	lw	a5,12(a5)
 288:	00f12c23          	sw	a5,24(sp)
 28c:	00455793          	srli	a5,a0,0x4
 290:	02078793          	addi	a5,a5,32
 294:	002787b3          	add	a5,a5,sp
 298:	fec7c783          	lbu	a5,-20(a5)
 29c:	00f58023          	sb	a5,0(a1)
 2a0:	00f57513          	andi	a0,a0,15
 2a4:	02050793          	addi	a5,a0,32
 2a8:	00278533          	add	a0,a5,sp
 2ac:	fec54783          	lbu	a5,-20(a0)
 2b0:	00f580a3          	sb	a5,1(a1)
 2b4:	02010113          	addi	sp,sp,32
 2b8:	00008067          	ret

000002bc <memory_to_hex_ascii>:
 2bc:	04058c63          	beqz	a1,314 <memory_to_hex_ascii+0x58>
 2c0:	ff010113          	addi	sp,sp,-16
 2c4:	00112623          	sw	ra,12(sp)
 2c8:	00812423          	sw	s0,8(sp)
 2cc:	00912223          	sw	s1,4(sp)
 2d0:	01212023          	sw	s2,0(sp)
 2d4:	fff58413          	addi	s0,a1,-1
 2d8:	00850433          	add	s0,a0,s0
 2dc:	00060493          	mv	s1,a2
 2e0:	fff50913          	addi	s2,a0,-1
 2e4:	00048593          	mv	a1,s1
 2e8:	00044503          	lbu	a0,0(s0)
 2ec:	f75ff0ef          	jal	260 <byte_to_hex>
 2f0:	fff40413          	addi	s0,s0,-1
 2f4:	00248493          	addi	s1,s1,2
 2f8:	ff2416e3          	bne	s0,s2,2e4 <memory_to_hex_ascii+0x28>
 2fc:	00c12083          	lw	ra,12(sp)
 300:	00812403          	lw	s0,8(sp)
 304:	00412483          	lw	s1,4(sp)
 308:	00012903          	lw	s2,0(sp)
 30c:	01010113          	addi	sp,sp,16
 310:	00008067          	ret
 314:	00008067          	ret

00000318 <print_int>:
 318:	fe010113          	addi	sp,sp,-32
 31c:	00112e23          	sw	ra,28(sp)
 320:	00812c23          	sw	s0,24(sp)
 324:	00050413          	mv	s0,a0
 328:	0a054c63          	bltz	a0,3e0 <print_int+0xc8>
 32c:	0c050663          	beqz	a0,3f8 <print_int+0xe0>
 330:	00000693          	li	a3,0
 334:	66666837          	lui	a6,0x66666
 338:	66780813          	addi	a6,a6,1639 # 66666667 <_stack_start+0x66662667>
 33c:	00900893          	li	a7,9
 340:	0ff6f593          	zext.b	a1,a3
 344:	00068613          	mv	a2,a3
 348:	00158693          	addi	a3,a1,1
 34c:	01869693          	slli	a3,a3,0x18
 350:	4186d693          	srai	a3,a3,0x18
 354:	01060793          	addi	a5,a2,16
 358:	00278533          	add	a0,a5,sp
 35c:	03041733          	mulh	a4,s0,a6
 360:	40275713          	srai	a4,a4,0x2
 364:	41f45793          	srai	a5,s0,0x1f
 368:	40f70733          	sub	a4,a4,a5
 36c:	00271793          	slli	a5,a4,0x2
 370:	00e787b3          	add	a5,a5,a4
 374:	00179793          	slli	a5,a5,0x1
 378:	40f407b3          	sub	a5,s0,a5
 37c:	03078793          	addi	a5,a5,48
 380:	fef50a23          	sb	a5,-12(a0)
 384:	00040793          	mv	a5,s0
 388:	00070413          	mv	s0,a4
 38c:	faf8cae3          	blt	a7,a5,340 <print_int+0x28>
 390:	04064063          	bltz	a2,3d0 <print_int+0xb8>
 394:	00912a23          	sw	s1,20(sp)
 398:	01212823          	sw	s2,16(sp)
 39c:	00410413          	addi	s0,sp,4
 3a0:	00c40433          	add	s0,s0,a2
 3a4:	00310493          	addi	s1,sp,3
 3a8:	00c484b3          	add	s1,s1,a2
 3ac:	40b484b3          	sub	s1,s1,a1
 3b0:	00100913          	li	s2,1
 3b4:	00090593          	mv	a1,s2
 3b8:	00040513          	mv	a0,s0
 3bc:	64c000ef          	jal	a08 <uart_write>
 3c0:	fff40413          	addi	s0,s0,-1
 3c4:	fe8498e3          	bne	s1,s0,3b4 <print_int+0x9c>
 3c8:	01412483          	lw	s1,20(sp)
 3cc:	01012903          	lw	s2,16(sp)
 3d0:	01c12083          	lw	ra,28(sp)
 3d4:	01812403          	lw	s0,24(sp)
 3d8:	02010113          	addi	sp,sp,32
 3dc:	00008067          	ret
 3e0:	00100593          	li	a1,1
 3e4:	00001537          	lui	a0,0x1
 3e8:	b1450513          	addi	a0,a0,-1260 # b14 <uart_elem_count+0x20>
 3ec:	61c000ef          	jal	a08 <uart_write>
 3f0:	40800433          	neg	s0,s0
 3f4:	f3dff06f          	j	330 <print_int+0x18>
 3f8:	00100593          	li	a1,1
 3fc:	00001537          	lui	a0,0x1
 400:	b1850513          	addi	a0,a0,-1256 # b18 <uart_elem_count+0x24>
 404:	604000ef          	jal	a08 <uart_write>
 408:	fc9ff06f          	j	3d0 <print_int+0xb8>

0000040c <print_float>:
 40c:	fd010113          	addi	sp,sp,-48
 410:	02112623          	sw	ra,44(sp)
 414:	02812423          	sw	s0,40(sp)
 418:	00812e27          	fsw	fs0,28(sp)
 41c:	20a50453          	fmv.s	fs0,fa0
 420:	20a517d3          	fneg.s	fa5,fa0
 424:	c00797d3          	fcvt.w.s	a5,fa5,rtz
 428:	d007f7d3          	fcvt.s.w	fa5,a5
 42c:	00a7f7d3          	fadd.s	fa5,fa5,fa0
 430:	00001737          	lui	a4,0x1
 434:	b6472707          	flw	fa4,-1180(a4) # b64 <uart_elem_count+0x70>
 438:	10e7f7d3          	fmul.s	fa5,fa5,fa4
 43c:	c0079453          	fcvt.w.s	s0,fa5,rtz
 440:	08044063          	bltz	s0,4c0 <print_float+0xb4>
 444:	c0041553          	fcvt.w.s	a0,fs0,rtz
 448:	ed1ff0ef          	jal	318 <print_int>
 44c:	00100593          	li	a1,1
 450:	00001537          	lui	a0,0x1
 454:	b1c50513          	addi	a0,a0,-1252 # b1c <uart_elem_count+0x28>
 458:	5b0000ef          	jal	a08 <uart_write>
 45c:	00c10693          	addi	a3,sp,12
 460:	00810593          	addi	a1,sp,8
 464:	66666637          	lui	a2,0x66666
 468:	66760613          	addi	a2,a2,1639 # 66666667 <_stack_start+0x66662667>
 46c:	02c41733          	mulh	a4,s0,a2
 470:	40275713          	srai	a4,a4,0x2
 474:	41f45793          	srai	a5,s0,0x1f
 478:	40f70733          	sub	a4,a4,a5
 47c:	00271793          	slli	a5,a4,0x2
 480:	00e787b3          	add	a5,a5,a4
 484:	00179793          	slli	a5,a5,0x1
 488:	40f407b3          	sub	a5,s0,a5
 48c:	03078793          	addi	a5,a5,48
 490:	00f681a3          	sb	a5,3(a3)
 494:	00070413          	mv	s0,a4
 498:	fff68693          	addi	a3,a3,-1
 49c:	fcb698e3          	bne	a3,a1,46c <print_float+0x60>
 4a0:	00400593          	li	a1,4
 4a4:	00c10513          	addi	a0,sp,12
 4a8:	560000ef          	jal	a08 <uart_write>
 4ac:	02c12083          	lw	ra,44(sp)
 4b0:	02812403          	lw	s0,40(sp)
 4b4:	01c12407          	flw	fs0,28(sp)
 4b8:	03010113          	addi	sp,sp,48
 4bc:	00008067          	ret
 4c0:	00078663          	beqz	a5,4cc <print_float+0xc0>
 4c4:	40800433          	neg	s0,s0
 4c8:	f7dff06f          	j	444 <print_float+0x38>
 4cc:	00100593          	li	a1,1
 4d0:	00001537          	lui	a0,0x1
 4d4:	b1450513          	addi	a0,a0,-1260 # b14 <uart_elem_count+0x20>
 4d8:	530000ef          	jal	a08 <uart_write>
 4dc:	fe9ff06f          	j	4c4 <print_float+0xb8>

000004e0 <forward_pass>:
 4e0:	04078e63          	beqz	a5,53c <forward_pass+0x5c>
 4e4:	00279e13          	slli	t3,a5,0x2
 4e8:	00259313          	slli	t1,a1,0x2
 4ec:	00650333          	add	t1,a0,t1
 4f0:	00000e93          	li	t4,0
 4f4:	00000f13          	li	t5,0
 4f8:	01d68833          	add	a6,a3,t4
 4fc:	00082707          	flw	fa4,0(a6)
 500:	02058463          	beqz	a1,528 <forward_pass+0x48>
 504:	01d608b3          	add	a7,a2,t4
 508:	00050813          	mv	a6,a0
 50c:	00082787          	flw	fa5,0(a6)
 510:	0008a687          	flw	fa3,0(a7)
 514:	10d7f7d3          	fmul.s	fa5,fa5,fa3
 518:	00f77753          	fadd.s	fa4,fa4,fa5
 51c:	00480813          	addi	a6,a6,4
 520:	01c888b3          	add	a7,a7,t3
 524:	fe6814e3          	bne	a6,t1,50c <forward_pass+0x2c>
 528:	01d70833          	add	a6,a4,t4
 52c:	00e82027          	fsw	fa4,0(a6)
 530:	001f0f13          	addi	t5,t5,1
 534:	004e8e93          	addi	t4,t4,4
 538:	fde790e3          	bne	a5,t5,4f8 <forward_pass+0x18>
 53c:	00008067          	ret

00000540 <ReLU>:
 540:	02058863          	beqz	a1,570 <ReLU+0x30>
 544:	00050793          	mv	a5,a0
 548:	00259593          	slli	a1,a1,0x2
 54c:	00b50533          	add	a0,a0,a1
 550:	0100006f          	j	560 <ReLU+0x20>
 554:	0007a023          	sw	zero,0(a5)
 558:	00478793          	addi	a5,a5,4
 55c:	00a78a63          	beq	a5,a0,570 <ReLU+0x30>
 560:	0007a787          	flw	fa5,0(a5)
 564:	c0079753          	fcvt.w.s	a4,fa5,rtz
 568:	fe0758e3          	bgez	a4,558 <ReLU+0x18>
 56c:	fe9ff06f          	j	554 <ReLU+0x14>
 570:	00008067          	ret

00000574 <tanh_activation>:
 574:	08058063          	beqz	a1,5f4 <tanh_activation+0x80>
 578:	00050793          	mv	a5,a0
 57c:	00259593          	slli	a1,a1,0x2
 580:	00b50533          	add	a0,a0,a1
 584:	ffd00613          	li	a2,-3
 588:	00001737          	lui	a4,0x1
 58c:	b6872607          	flw	fa2,-1176(a4) # b68 <uart_elem_count+0x74>
 590:	00300593          	li	a1,3
 594:	00001737          	lui	a4,0x1
 598:	b6c72507          	flw	fa0,-1172(a4) # b6c <uart_elem_count+0x78>
 59c:	00001737          	lui	a4,0x1
 5a0:	b7072587          	flw	fa1,-1168(a4) # b70 <uart_elem_count+0x7c>
 5a4:	00001737          	lui	a4,0x1
 5a8:	b7472007          	flw	ft0,-1164(a4) # b74 <uart_elem_count+0x80>
 5ac:	0100006f          	j	5bc <tanh_activation+0x48>
 5b0:	00f6a027          	fsw	fa5,0(a3)
 5b4:	00478793          	addi	a5,a5,4
 5b8:	02a78e63          	beq	a5,a0,5f4 <tanh_activation+0x80>
 5bc:	00078693          	mv	a3,a5
 5c0:	0007a707          	flw	fa4,0(a5)
 5c4:	c0071753          	fcvt.w.s	a4,fa4,rtz
 5c8:	20c607d3          	fmv.s	fa5,fa2
 5cc:	fec742e3          	blt	a4,a2,5b0 <tanh_activation+0x3c>
 5d0:	20a507d3          	fmv.s	fa5,fa0
 5d4:	fce5cee3          	blt	a1,a4,5b0 <tanh_activation+0x3c>
 5d8:	10e776d3          	fmul.s	fa3,fa4,fa4
 5dc:	00b6f7d3          	fadd.s	fa5,fa3,fa1
 5e0:	10e7f7d3          	fmul.s	fa5,fa5,fa4
 5e4:	1006f6d3          	fmul.s	fa3,fa3,ft0
 5e8:	00b6f6d3          	fadd.s	fa3,fa3,fa1
 5ec:	18d7f7d3          	fdiv.s	fa5,fa5,fa3
 5f0:	fc1ff06f          	j	5b0 <tanh_activation+0x3c>
 5f4:	00008067          	ret

000005f8 <forward_pass_quantized>:
 5f8:	06078063          	beqz	a5,658 <forward_pass_quantized+0x60>
 5fc:	00259e13          	slli	t3,a1,0x2
 600:	01c50e33          	add	t3,a0,t3
 604:	00000e93          	li	t4,0
 608:	01d68833          	add	a6,a3,t4
 60c:	00080803          	lb	a6,0(a6)
 610:	d0087753          	fcvt.s.w	fa4,a6
 614:	10b77753          	fmul.s	fa4,fa4,fa1
 618:	02058863          	beqz	a1,648 <forward_pass_quantized+0x50>
 61c:	01d608b3          	add	a7,a2,t4
 620:	00050813          	mv	a6,a0
 624:	00088303          	lb	t1,0(a7)
 628:	d00377d3          	fcvt.s.w	fa5,t1
 62c:	00082687          	flw	fa3,0(a6)
 630:	10d7f7d3          	fmul.s	fa5,fa5,fa3
 634:	10a7f7d3          	fmul.s	fa5,fa5,fa0
 638:	00f77753          	fadd.s	fa4,fa4,fa5
 63c:	00480813          	addi	a6,a6,4
 640:	00f888b3          	add	a7,a7,a5
 644:	ffc810e3          	bne	a6,t3,624 <forward_pass_quantized+0x2c>
 648:	00e72027          	fsw	fa4,0(a4)
 64c:	001e8e93          	addi	t4,t4,1
 650:	00470713          	addi	a4,a4,4
 654:	fbd79ae3          	bne	a5,t4,608 <forward_pass_quantized+0x10>
 658:	00008067          	ret

0000065c <tanh_activation_quantized>:
 65c:	08058063          	beqz	a1,6dc <tanh_activation_quantized+0x80>
 660:	00050793          	mv	a5,a0
 664:	00259593          	slli	a1,a1,0x2
 668:	00b50533          	add	a0,a0,a1
 66c:	ffd00613          	li	a2,-3
 670:	00001737          	lui	a4,0x1
 674:	b6872607          	flw	fa2,-1176(a4) # b68 <uart_elem_count+0x74>
 678:	00300593          	li	a1,3
 67c:	00001737          	lui	a4,0x1
 680:	b6c72507          	flw	fa0,-1172(a4) # b6c <uart_elem_count+0x78>
 684:	00001737          	lui	a4,0x1
 688:	b7072587          	flw	fa1,-1168(a4) # b70 <uart_elem_count+0x7c>
 68c:	00001737          	lui	a4,0x1
 690:	b7472007          	flw	ft0,-1164(a4) # b74 <uart_elem_count+0x80>
 694:	0100006f          	j	6a4 <tanh_activation_quantized+0x48>
 698:	00f6a027          	fsw	fa5,0(a3)
 69c:	00478793          	addi	a5,a5,4
 6a0:	02a78e63          	beq	a5,a0,6dc <tanh_activation_quantized+0x80>
 6a4:	00078693          	mv	a3,a5
 6a8:	0007a707          	flw	fa4,0(a5)
 6ac:	c0071753          	fcvt.w.s	a4,fa4,rtz
 6b0:	20c607d3          	fmv.s	fa5,fa2
 6b4:	fec742e3          	blt	a4,a2,698 <tanh_activation_quantized+0x3c>
 6b8:	20a507d3          	fmv.s	fa5,fa0
 6bc:	fce5cee3          	blt	a1,a4,698 <tanh_activation_quantized+0x3c>
 6c0:	10e776d3          	fmul.s	fa3,fa4,fa4
 6c4:	00b6f7d3          	fadd.s	fa5,fa3,fa1
 6c8:	10e7f7d3          	fmul.s	fa5,fa5,fa4
 6cc:	1006f6d3          	fmul.s	fa3,fa3,ft0
 6d0:	00b6f6d3          	fadd.s	fa3,fa3,fa1
 6d4:	18d7f7d3          	fdiv.s	fa5,fa5,fa3
 6d8:	fc1ff06f          	j	698 <tanh_activation_quantized+0x3c>
 6dc:	00008067          	ret

000006e0 <delay_ms>:
 6e0:	00050693          	mv	a3,a0
 6e4:	00000713          	li	a4,0
 6e8:	02050463          	beqz	a0,710 <delay_ms+0x30>
 6ec:	000017b7          	lui	a5,0x1
 6f0:	9c378793          	addi	a5,a5,-1597 # 9c3 <main+0x27b>
 6f4:	00000013          	nop
 6f8:	00000013          	nop
 6fc:	fff78793          	addi	a5,a5,-1
 700:	fe079ae3          	bnez	a5,6f4 <delay_ms+0x14>
 704:	00170713          	addi	a4,a4,1
 708:	fee692e3          	bne	a3,a4,6ec <delay_ms+0xc>
 70c:	00008067          	ret
 710:	00008067          	ret

00000714 <delay_us>:
 714:	00100793          	li	a5,1
 718:	02a7f663          	bgeu	a5,a0,744 <delay_us+0x30>
 71c:	00000013          	nop
 720:	00000013          	nop
 724:	00000013          	nop
 728:	00000013          	nop
 72c:	00000013          	nop
 730:	00000013          	nop
 734:	00000013          	nop
 738:	00000013          	nop
 73c:	00178793          	addi	a5,a5,1
 740:	fcf51ee3          	bne	a0,a5,71c <delay_us+0x8>
 744:	00008067          	ret

00000748 <main>:
 748:	fd010113          	addi	sp,sp,-48
 74c:	02112623          	sw	ra,44(sp)
 750:	02812423          	sw	s0,40(sp)
 754:	02912223          	sw	s1,36(sp)
 758:	03212023          	sw	s2,32(sp)
 75c:	01312e23          	sw	s3,28(sp)
 760:	01412c23          	sw	s4,24(sp)
 764:	01512a23          	sw	s5,20(sp)
 768:	01612823          	sw	s6,16(sp)
 76c:	00812627          	fsw	fs0,12(sp)
 770:	00912427          	fsw	fs1,8(sp)
 774:	01212227          	fsw	fs2,4(sp)
 778:	00300513          	li	a0,3
 77c:	254000ef          	jal	9d0 <uart_enable>
 780:	1f000513          	li	a0,496
 784:	a51ff0ef          	jal	1d4 <enable_interrupts>
 788:	00700593          	li	a1,7
 78c:	00001537          	lui	a0,0x1
 790:	b2050513          	addi	a0,a0,-1248 # b20 <uart_elem_count+0x2c>
 794:	274000ef          	jal	a08 <uart_write>
 798:	00001537          	lui	a0,0x1
 79c:	04000793          	li	a5,64
 7a0:	b8f52023          	sw	a5,-1152(a0) # b80 <data>
 7a4:	00200613          	li	a2,2
 7a8:	00000593          	li	a1,0
 7ac:	b8050513          	addi	a0,a0,-1152
 7b0:	94dff0ef          	jal	fc <output_data>
 7b4:	00001a37          	lui	s4,0x1
 7b8:	00200413          	li	s0,2
 7bc:	b80a0493          	addi	s1,s4,-1152 # b80 <data>
 7c0:	000019b7          	lui	s3,0x1
 7c4:	b8498913          	addi	s2,s3,-1148 # b84 <gp_state>
 7c8:	000017b7          	lui	a5,0x1
 7cc:	b787a907          	flw	fs2,-1160(a5) # b78 <uart_elem_count+0x84>
 7d0:	000017b7          	lui	a5,0x1
 7d4:	b7c7a487          	flw	fs1,-1156(a5) # b7c <uart_elem_count+0x88>
 7d8:	1040006f          	j	8dc <main+0x194>
 7dc:	04100793          	li	a5,65
 7e0:	b8fa2023          	sw	a5,-1152(s4)
 7e4:	00040613          	mv	a2,s0
 7e8:	00000593          	li	a1,0
 7ec:	00048513          	mv	a0,s1
 7f0:	90dff0ef          	jal	fc <output_data>
 7f4:	00040613          	mv	a2,s0
 7f8:	00000593          	li	a1,0
 7fc:	00090513          	mv	a0,s2
 800:	959ff0ef          	jal	158 <input_data>
 804:	04200793          	li	a5,66
 808:	b8fa2023          	sw	a5,-1152(s4)
 80c:	00040613          	mv	a2,s0
 810:	00000593          	li	a1,0
 814:	00048513          	mv	a0,s1
 818:	8e5ff0ef          	jal	fc <output_data>
 81c:	00040613          	mv	a2,s0
 820:	00000593          	li	a1,0
 824:	00001b37          	lui	s6,0x1
 828:	b8cb0513          	addi	a0,s6,-1140 # b8c <cycles_start>
 82c:	92dff0ef          	jal	158 <input_data>
 830:	04300793          	li	a5,67
 834:	b8fa2023          	sw	a5,-1152(s4)
 838:	00040613          	mv	a2,s0
 83c:	00000593          	li	a1,0
 840:	00048513          	mv	a0,s1
 844:	8b9ff0ef          	jal	fc <output_data>
 848:	00040613          	mv	a2,s0
 84c:	00000593          	li	a1,0
 850:	00001ab7          	lui	s5,0x1
 854:	b88a8513          	addi	a0,s5,-1144 # b88 <cycles_end>
 858:	901ff0ef          	jal	158 <input_data>
 85c:	b88aaa83          	lw	s5,-1144(s5)
 860:	b8cb2783          	lw	a5,-1140(s6)
 864:	40fa8ab3          	sub	s5,s5,a5
 868:	00f00593          	li	a1,15
 86c:	00001537          	lui	a0,0x1
 870:	b2850513          	addi	a0,a0,-1240 # b28 <uart_elem_count+0x34>
 874:	194000ef          	jal	a08 <uart_write>
 878:	00d00593          	li	a1,13
 87c:	00001537          	lui	a0,0x1
 880:	b3850513          	addi	a0,a0,-1224 # b38 <uart_elem_count+0x44>
 884:	184000ef          	jal	a08 <uart_write>
 888:	d01af453          	fcvt.s.wu	fs0,s5
 88c:	20840553          	fmv.s	fa0,fs0
 890:	b7dff0ef          	jal	40c <print_float>
 894:	00040593          	mv	a1,s0
 898:	00001537          	lui	a0,0x1
 89c:	b3450513          	addi	a0,a0,-1228 # b34 <uart_elem_count+0x40>
 8a0:	168000ef          	jal	a08 <uart_write>
 8a4:	11247453          	fmul.s	fs0,fs0,fs2
 8a8:	18947453          	fdiv.s	fs0,fs0,fs1
 8ac:	01400593          	li	a1,20
 8b0:	00001537          	lui	a0,0x1
 8b4:	b4850513          	addi	a0,a0,-1208 # b48 <uart_elem_count+0x54>
 8b8:	150000ef          	jal	a08 <uart_write>
 8bc:	20840553          	fmv.s	fa0,fs0
 8c0:	b4dff0ef          	jal	40c <print_float>
 8c4:	00500593          	li	a1,5
 8c8:	00001537          	lui	a0,0x1
 8cc:	b5c50513          	addi	a0,a0,-1188 # b5c <uart_elem_count+0x68>
 8d0:	138000ef          	jal	a08 <uart_write>
 8d4:	3e800513          	li	a0,1000
 8d8:	e09ff0ef          	jal	6e0 <delay_ms>
 8dc:	14000793          	li	a5,320
 8e0:	b8fa2023          	sw	a5,-1152(s4)
 8e4:	00040613          	mv	a2,s0
 8e8:	00000593          	li	a1,0
 8ec:	00048513          	mv	a0,s1
 8f0:	80dff0ef          	jal	fc <output_data>
 8f4:	00a00513          	li	a0,10
 8f8:	e1dff0ef          	jal	714 <delay_us>
 8fc:	04000793          	li	a5,64
 900:	b8fa2023          	sw	a5,-1152(s4)
 904:	00040613          	mv	a2,s0
 908:	00000593          	li	a1,0
 90c:	00048513          	mv	a0,s1
 910:	fecff0ef          	jal	fc <output_data>
 914:	04100793          	li	a5,65
 918:	b8fa2023          	sw	a5,-1152(s4)
 91c:	00040613          	mv	a2,s0
 920:	00000593          	li	a1,0
 924:	00048513          	mv	a0,s1
 928:	fd4ff0ef          	jal	fc <output_data>
 92c:	00040613          	mv	a2,s0
 930:	00000593          	li	a1,0
 934:	00090513          	mv	a0,s2
 938:	821ff0ef          	jal	158 <input_data>
 93c:	b849a783          	lw	a5,-1148(s3)
 940:	0017f793          	andi	a5,a5,1
 944:	02079863          	bnez	a5,974 <main+0x22c>
 948:	00040613          	mv	a2,s0
 94c:	00000593          	li	a1,0
 950:	00048513          	mv	a0,s1
 954:	fa8ff0ef          	jal	fc <output_data>
 958:	00040613          	mv	a2,s0
 95c:	00000593          	li	a1,0
 960:	00090513          	mv	a0,s2
 964:	ff4ff0ef          	jal	158 <input_data>
 968:	b849a783          	lw	a5,-1148(s3)
 96c:	0017f793          	andi	a5,a5,1
 970:	fc078ce3          	beqz	a5,948 <main+0x200>
 974:	00040613          	mv	a2,s0
 978:	00000593          	li	a1,0
 97c:	00048513          	mv	a0,s1
 980:	f7cff0ef          	jal	fc <output_data>
 984:	00040613          	mv	a2,s0
 988:	00000593          	li	a1,0
 98c:	00090513          	mv	a0,s2
 990:	fc8ff0ef          	jal	158 <input_data>
 994:	b849a783          	lw	a5,-1148(s3)
 998:	0017f793          	andi	a5,a5,1
 99c:	e40780e3          	beqz	a5,7dc <main+0x94>
 9a0:	00040613          	mv	a2,s0
 9a4:	00000593          	li	a1,0
 9a8:	00048513          	mv	a0,s1
 9ac:	f50ff0ef          	jal	fc <output_data>
 9b0:	00040613          	mv	a2,s0
 9b4:	00000593          	li	a1,0
 9b8:	00090513          	mv	a0,s2
 9bc:	f9cff0ef          	jal	158 <input_data>
 9c0:	b849a783          	lw	a5,-1148(s3)
 9c4:	0017f793          	andi	a5,a5,1
 9c8:	fc079ce3          	bnez	a5,9a0 <main+0x258>
 9cc:	e11ff06f          	j	7dc <main+0x94>

000009d0 <uart_enable>:
 9d0:	ff010113          	addi	sp,sp,-16
 9d4:	00112623          	sw	ra,12(sp)
 9d8:	80000737          	lui	a4,0x80000
 9dc:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fffc000>
 9e0:	00357513          	andi	a0,a0,3
 9e4:	fff54513          	not	a0,a0
 9e8:	00a7f7b3          	and	a5,a5,a0
 9ec:	00f70023          	sb	a5,0(a4)
 9f0:	00001537          	lui	a0,0x1
 9f4:	b9450513          	addi	a0,a0,-1132 # b94 <uart_read_buff>
 9f8:	e20ff0ef          	jal	18 <circ_buf_init>
 9fc:	00c12083          	lw	ra,12(sp)
 a00:	01010113          	addi	sp,sp,16
 a04:	00008067          	ret

00000a08 <uart_write>:
 a08:	04058463          	beqz	a1,a50 <uart_write+0x48>
 a0c:	00050693          	mv	a3,a0
 a10:	00b50633          	add	a2,a0,a1
 a14:	80000737          	lui	a4,0x80000
 a18:	00170593          	addi	a1,a4,1 # 80000001 <_stack_start+0x7fffc001>
 a1c:	00074783          	lbu	a5,0(a4)
 a20:	0047f793          	andi	a5,a5,4
 a24:	fe078ce3          	beqz	a5,a1c <uart_write+0x14>
 a28:	0006c783          	lbu	a5,0(a3)
 a2c:	00f58023          	sb	a5,0(a1)
 a30:	00074783          	lbu	a5,0(a4)
 a34:	0107e793          	ori	a5,a5,16
 a38:	00f70023          	sb	a5,0(a4)
 a3c:	00074783          	lbu	a5,0(a4)
 a40:	0ef7f793          	andi	a5,a5,239
 a44:	00f70023          	sb	a5,0(a4)
 a48:	00168693          	addi	a3,a3,1
 a4c:	fcc698e3          	bne	a3,a2,a1c <uart_write+0x14>
 a50:	80000737          	lui	a4,0x80000
 a54:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fffc000>
 a58:	0ef7f793          	andi	a5,a5,239
 a5c:	00f70023          	sb	a5,0(a4)
 a60:	00074783          	lbu	a5,0(a4)
 a64:	0047f793          	andi	a5,a5,4
 a68:	fe078ce3          	beqz	a5,a60 <uart_write+0x58>
 a6c:	00008067          	ret

00000a70 <uart_read>:
 a70:	ff010113          	addi	sp,sp,-16
 a74:	00112623          	sw	ra,12(sp)
 a78:	00050593          	mv	a1,a0
 a7c:	00001537          	lui	a0,0x1
 a80:	b9450513          	addi	a0,a0,-1132 # b94 <uart_read_buff>
 a84:	e04ff0ef          	jal	88 <circ_buf_read>
 a88:	00100513          	li	a0,1
 a8c:	00c12083          	lw	ra,12(sp)
 a90:	01010113          	addi	sp,sp,16
 a94:	00008067          	ret

00000a98 <uart_Rx_ISR>:
 a98:	ff010113          	addi	sp,sp,-16
 a9c:	00112623          	sw	ra,12(sp)
 aa0:	800007b7          	lui	a5,0x80000
 aa4:	0027c583          	lbu	a1,2(a5) # 80000002 <_stack_start+0x7fffc002>
 aa8:	00001537          	lui	a0,0x1
 aac:	b9450513          	addi	a0,a0,-1132 # b94 <uart_read_buff>
 ab0:	d8cff0ef          	jal	3c <circ_buf_write>
 ab4:	00c12083          	lw	ra,12(sp)
 ab8:	01010113          	addi	sp,sp,16
 abc:	00008067          	ret

00000ac0 <uart_disable>:
 ac0:	ff010113          	addi	sp,sp,-16
 ac4:	00112623          	sw	ra,12(sp)
 ac8:	80000737          	lui	a4,0x80000
 acc:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fffc000>
 ad0:	00357513          	andi	a0,a0,3
 ad4:	00a7e7b3          	or	a5,a5,a0
 ad8:	00f70023          	sb	a5,0(a4)
 adc:	00001537          	lui	a0,0x1
 ae0:	b9450513          	addi	a0,a0,-1132 # b94 <uart_read_buff>
 ae4:	d44ff0ef          	jal	28 <circ_buf_close>
 ae8:	00c12083          	lw	ra,12(sp)
 aec:	01010113          	addi	sp,sp,16
 af0:	00008067          	ret

00000af4 <uart_elem_count>:
 af4:	000017b7          	lui	a5,0x1
 af8:	c157c503          	lbu	a0,-1003(a5) # c15 <uart_read_buff+0x81>
 afc:	00008067          	ret
