
first.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <Reset>:
       0:	00008117          	auipc	sp,0x8
       4:	00010113          	mv	sp,sp
       8:	3fc000ef          	jal	404 <disable_interrupts>
       c:	00300513          	li	a0,3
      10:	075010ef          	jal	1884 <uart_disable>
      14:	2ac010ef          	jal	12c0 <main>

00000018 <number>:
      18:	0407f813          	andi	a6,a5,64
      1c:	04081863          	bnez	a6,6c <number+0x54>
      20:	00002f37          	lui	t5,0x2
      24:	8ccf0f13          	addi	t5,t5,-1844 # 18cc <circ_buf_close+0x14>
      28:	0107f813          	andi	a6,a5,16
      2c:	04080663          	beqz	a6,78 <number+0x60>
      30:	00060313          	mv	t1,a2
      34:	ffe60813          	addi	a6,a2,-2
      38:	02200893          	li	a7,34
      3c:	2508ec63          	bltu	a7,a6,294 <number+0x27c>
      40:	ffe7f793          	andi	a5,a5,-2
      44:	02000e13          	li	t3,32
      48:	fb010113          	addi	sp,sp,-80 # 7fb0 <uart_read_buff+0x617c>
      4c:	0027f813          	andi	a6,a5,2
      50:	08080263          	beqz	a6,d4 <number+0xbc>
      54:	0405c663          	bltz	a1,a0 <number+0x88>
      58:	0047f813          	andi	a6,a5,4
      5c:	06080063          	beqz	a6,bc <number+0xa4>
      60:	fff68693          	addi	a3,a3,-1
      64:	02b00393          	li	t2,43
      68:	0700006f          	j	d8 <number+0xc0>
      6c:	00002f37          	lui	t5,0x2
      70:	8f4f0f13          	addi	t5,t5,-1804 # 18f4 <circ_buf_close+0x3c>
      74:	fb5ff06f          	j	28 <number+0x10>
      78:	00060313          	mv	t1,a2
      7c:	ffe60813          	addi	a6,a2,-2
      80:	02200893          	li	a7,34
      84:	2108ec63          	bltu	a7,a6,29c <number+0x284>
      88:	0017fe13          	andi	t3,a5,1
      8c:	001e3e13          	seqz	t3,t3
      90:	41c00e33          	neg	t3,t3
      94:	ff0e7e13          	andi	t3,t3,-16
      98:	030e0e13          	addi	t3,t3,48
      9c:	fadff06f          	j	48 <number+0x30>
      a0:	40b005b3          	neg	a1,a1
      a4:	fff68693          	addi	a3,a3,-1
      a8:	0207f293          	andi	t0,a5,32
      ac:	02d00393          	li	t2,45
      b0:	06028063          	beqz	t0,110 <number+0xf8>
      b4:	02d00393          	li	t2,45
      b8:	0280006f          	j	e0 <number+0xc8>
      bc:	0087f813          	andi	a6,a5,8
      c0:	00000393          	li	t2,0
      c4:	00080a63          	beqz	a6,d8 <number+0xc0>
      c8:	fff68693          	addi	a3,a3,-1
      cc:	02000393          	li	t2,32
      d0:	0080006f          	j	d8 <number+0xc0>
      d4:	00000393          	li	t2,0
      d8:	0207f293          	andi	t0,a5,32
      dc:	00028c63          	beqz	t0,f4 <number+0xdc>
      e0:	01000813          	li	a6,16
      e4:	03060263          	beq	a2,a6,108 <number+0xf0>
      e8:	ff860813          	addi	a6,a2,-8
      ec:	00183813          	seqz	a6,a6
      f0:	410686b3          	sub	a3,a3,a6
      f4:	00059e63          	bnez	a1,110 <number+0xf8>
      f8:	03000593          	li	a1,48
      fc:	00b10623          	sb	a1,12(sp)
     100:	00100813          	li	a6,1
     104:	0340006f          	j	138 <number+0x120>
     108:	ffe68693          	addi	a3,a3,-2
     10c:	fe9ff06f          	j	f4 <number+0xdc>
     110:	00000813          	li	a6,0
     114:	00c10f93          	addi	t6,sp,12
     118:	00180813          	addi	a6,a6,1
     11c:	010f8eb3          	add	t4,t6,a6
     120:	0265f8b3          	remu	a7,a1,t1
     124:	011f08b3          	add	a7,t5,a7
     128:	0008c883          	lbu	a7,0(a7)
     12c:	ff1e8fa3          	sb	a7,-1(t4)
     130:	0265d5b3          	divu	a1,a1,t1
     134:	fe0592e3          	bnez	a1,118 <number+0x100>
     138:	00080e93          	mv	t4,a6
     13c:	00e85463          	bge	a6,a4,144 <number+0x12c>
     140:	00070e93          	mv	t4,a4
     144:	41d686b3          	sub	a3,a3,t4
     148:	0117f593          	andi	a1,a5,17
     14c:	02059663          	bnez	a1,178 <number+0x160>
     150:	00068f13          	mv	t5,a3
     154:	00d50333          	add	t1,a0,a3
     158:	00050593          	mv	a1,a0
     15c:	02000893          	li	a7,32
     160:	0ed05e63          	blez	a3,25c <number+0x244>
     164:	00158593          	addi	a1,a1,1
     168:	ff158fa3          	sb	a7,-1(a1)
     16c:	fe659ce3          	bne	a1,t1,164 <number+0x14c>
     170:	01e50533          	add	a0,a0,t5
     174:	fff00693          	li	a3,-1
     178:	00038663          	beqz	t2,184 <number+0x16c>
     17c:	00750023          	sb	t2,0(a0)
     180:	00150513          	addi	a0,a0,1
     184:	00028a63          	beqz	t0,198 <number+0x180>
     188:	00800593          	li	a1,8
     18c:	0cb60c63          	beq	a2,a1,264 <number+0x24c>
     190:	01000593          	li	a1,16
     194:	0eb60063          	beq	a2,a1,274 <number+0x25c>
     198:	0107f793          	andi	a5,a5,16
     19c:	02079463          	bnez	a5,1c4 <number+0x1ac>
     1a0:	00068593          	mv	a1,a3
     1a4:	00d50633          	add	a2,a0,a3
     1a8:	00050793          	mv	a5,a0
     1ac:	0ed05063          	blez	a3,28c <number+0x274>
     1b0:	00178793          	addi	a5,a5,1
     1b4:	ffc78fa3          	sb	t3,-1(a5)
     1b8:	fec79ce3          	bne	a5,a2,1b0 <number+0x198>
     1bc:	00b50533          	add	a0,a0,a1
     1c0:	fff00693          	li	a3,-1
     1c4:	00050793          	mv	a5,a0
     1c8:	03000893          	li	a7,48
     1cc:	00050313          	mv	t1,a0
     1d0:	00ae85b3          	add	a1,t4,a0
     1d4:	02e85663          	bge	a6,a4,200 <number+0x1e8>
     1d8:	00178793          	addi	a5,a5,1
     1dc:	ff178fa3          	sb	a7,-1(a5)
     1e0:	40f58633          	sub	a2,a1,a5
     1e4:	fec84ae3          	blt	a6,a2,1d8 <number+0x1c0>
     1e8:	00000513          	li	a0,0
     1ec:	00e85663          	bge	a6,a4,1f8 <number+0x1e0>
     1f0:	410e8533          	sub	a0,t4,a6
     1f4:	fff50513          	addi	a0,a0,-1
     1f8:	00150513          	addi	a0,a0,1
     1fc:	00650533          	add	a0,a0,t1
     200:	03005863          	blez	a6,230 <number+0x218>
     204:	00050313          	mv	t1,a0
     208:	00c10593          	addi	a1,sp,12
     20c:	00080893          	mv	a7,a6
     210:	010587b3          	add	a5,a1,a6
     214:	00050713          	mv	a4,a0
     218:	fff7c603          	lbu	a2,-1(a5)
     21c:	00c70023          	sb	a2,0(a4)
     220:	00170713          	addi	a4,a4,1
     224:	fff78793          	addi	a5,a5,-1
     228:	feb798e3          	bne	a5,a1,218 <number+0x200>
     22c:	01130533          	add	a0,t1,a7
     230:	02d05263          	blez	a3,254 <number+0x23c>
     234:	00068613          	mv	a2,a3
     238:	00d506b3          	add	a3,a0,a3
     23c:	00050793          	mv	a5,a0
     240:	02000713          	li	a4,32
     244:	00178793          	addi	a5,a5,1
     248:	fee78fa3          	sb	a4,-1(a5)
     24c:	fed79ce3          	bne	a5,a3,244 <number+0x22c>
     250:	00c50533          	add	a0,a0,a2
     254:	05010113          	addi	sp,sp,80
     258:	00008067          	ret
     25c:	fff68693          	addi	a3,a3,-1
     260:	f19ff06f          	j	178 <number+0x160>
     264:	03000613          	li	a2,48
     268:	00c50023          	sb	a2,0(a0)
     26c:	00150513          	addi	a0,a0,1
     270:	f29ff06f          	j	198 <number+0x180>
     274:	03000613          	li	a2,48
     278:	00c50023          	sb	a2,0(a0)
     27c:	07800613          	li	a2,120
     280:	00c500a3          	sb	a2,1(a0)
     284:	00250513          	addi	a0,a0,2
     288:	f11ff06f          	j	198 <number+0x180>
     28c:	fff68693          	addi	a3,a3,-1
     290:	f35ff06f          	j	1c4 <number+0x1ac>
     294:	00000513          	li	a0,0
     298:	00008067          	ret
     29c:	00000513          	li	a0,0
     2a0:	00008067          	ret

000002a4 <cosine_from_rads_interp>:
     2a4:	c00517d3          	fcvt.w.s	a5,fa0,rtz
     2a8:	0007dc63          	bgez	a5,2c0 <cosine_from_rads_interp+0x1c>
     2ac:	000027b7          	lui	a5,0x2
     2b0:	bac7a787          	flw	fa5,-1108(a5) # 1bac <circ_buf_close+0x2f4>
     2b4:	00f57553          	fadd.s	fa0,fa0,fa5
     2b8:	c00517d3          	fcvt.w.s	a5,fa0,rtz
     2bc:	fe07cce3          	bltz	a5,2b4 <cosine_from_rads_interp+0x10>
     2c0:	000027b7          	lui	a5,0x2
     2c4:	bb07a787          	flw	fa5,-1104(a5) # 1bb0 <circ_buf_close+0x2f8>
     2c8:	10f577d3          	fmul.s	fa5,fa0,fa5
     2cc:	c0079753          	fcvt.w.s	a4,fa5,rtz
     2d0:	03d00793          	li	a5,61
     2d4:	02e7d463          	bge	a5,a4,2fc <cosine_from_rads_interp+0x58>
     2d8:	000027b7          	lui	a5,0x2
     2dc:	c047a687          	flw	fa3,-1020(a5) # 1c04 <MINUS_TWO_PI>
     2e0:	000027b7          	lui	a5,0x2
     2e4:	bb07a707          	flw	fa4,-1104(a5) # 1bb0 <circ_buf_close+0x2f8>
     2e8:	03d00713          	li	a4,61
     2ec:	00d57553          	fadd.s	fa0,fa0,fa3
     2f0:	10e577d3          	fmul.s	fa5,fa0,fa4
     2f4:	c00797d3          	fcvt.w.s	a5,fa5,rtz
     2f8:	fef74ae3          	blt	a4,a5,2ec <cosine_from_rads_interp+0x48>
     2fc:	000027b7          	lui	a5,0x2
     300:	bac7a787          	flw	fa5,-1108(a5) # 1bac <circ_buf_close+0x2f4>
     304:	18f57553          	fdiv.s	fa0,fa0,fa5
     308:	000027b7          	lui	a5,0x2
     30c:	bb47a787          	flw	fa5,-1100(a5) # 1bb4 <circ_buf_close+0x2fc>
     310:	10f57553          	fmul.s	fa0,fa0,fa5
     314:	c01517d3          	fcvt.wu.s	a5,fa0,rtz
     318:	0ff7f793          	zext.b	a5,a5
     31c:	00002737          	lui	a4,0x2
     320:	c0870713          	addi	a4,a4,-1016 # 1c08 <cosine_table>
     324:	00179693          	slli	a3,a5,0x1
     328:	00d706b3          	add	a3,a4,a3
     32c:	00069603          	lh	a2,0(a3)
     330:	00178693          	addi	a3,a5,1
     334:	0ff6f693          	zext.b	a3,a3
     338:	00169693          	slli	a3,a3,0x1
     33c:	00d70733          	add	a4,a4,a3
     340:	00071703          	lh	a4,0(a4)
     344:	40c70733          	sub	a4,a4,a2
     348:	d00777d3          	fcvt.s.w	fa5,a4
     34c:	40f007b3          	neg	a5,a5
     350:	d007f753          	fcvt.s.w	fa4,a5
     354:	00a77753          	fadd.s	fa4,fa4,fa0
     358:	10e7f7d3          	fmul.s	fa5,fa5,fa4
     35c:	d0067753          	fcvt.s.w	fa4,a2
     360:	00e7f7d3          	fadd.s	fa5,fa5,fa4
     364:	c0079553          	fcvt.w.s	a0,fa5,rtz
     368:	01051513          	slli	a0,a0,0x10
     36c:	41055513          	srai	a0,a0,0x10
     370:	00008067          	ret

00000374 <output_data>:
     374:	00050793          	mv	a5,a0
     378:	00058713          	mv	a4,a1
     37c:	00078513          	mv	a0,a5
     380:	00070593          	mv	a1,a4
     384:	00b50533          	add	a0,a0,a1
     388:	00400793          	li	a5,4
     38c:	02f60663          	beq	a2,a5,3b8 <output_data+0x44>
     390:	00c7ec63          	bltu	a5,a2,3a8 <output_data+0x34>
     394:	02060663          	beqz	a2,3c0 <output_data+0x4c>
     398:	00100793          	li	a5,1
     39c:	02f61663          	bne	a2,a5,3c8 <output_data+0x54>
     3a0:	00051008          	.word	0x00051008
     3a4:	00008067          	ret
     3a8:	00500793          	li	a5,5
     3ac:	00f61e63          	bne	a2,a5,3c8 <output_data+0x54>
     3b0:	00055008          	.word	0x00055008
     3b4:	00008067          	ret
     3b8:	00054008          	.word	0x00054008
     3bc:	00008067          	ret
     3c0:	00050008          	.word	0x00050008
     3c4:	00008067          	ret
     3c8:	00052008          	.word	0x00052008
     3cc:	00008067          	ret

000003d0 <input_data>:
     3d0:	00050793          	mv	a5,a0
     3d4:	00058713          	mv	a4,a1
     3d8:	00f70533          	add	a0,a4,a5
     3dc:	00400793          	li	a5,4
     3e0:	00f60a63          	beq	a2,a5,3f4 <input_data+0x24>
     3e4:	00500793          	li	a5,5
     3e8:	00f60a63          	beq	a2,a5,3fc <input_data+0x2c>
     3ec:	00a52077          	.word	0x00a52077
     3f0:	00008067          	ret
     3f4:	00050077          	.word	0x00050077
     3f8:	00008067          	ret
     3fc:	00051077          	.word	0x00051077
     400:	00008067          	ret

00000404 <disable_interrupts>:
     404:	0000001f          	.word	0x0000001f
     408:	00008067          	ret

0000040c <print_int>:
     40c:	fe010113          	addi	sp,sp,-32
     410:	00112e23          	sw	ra,28(sp)
     414:	00812c23          	sw	s0,24(sp)
     418:	00050413          	mv	s0,a0
     41c:	0a054c63          	bltz	a0,4d4 <print_int+0xc8>
     420:	0c050663          	beqz	a0,4ec <print_int+0xe0>
     424:	00000693          	li	a3,0
     428:	66666837          	lui	a6,0x66666
     42c:	66780813          	addi	a6,a6,1639 # 66666667 <_stack_start+0x6665e667>
     430:	00900893          	li	a7,9
     434:	0ff6f593          	zext.b	a1,a3
     438:	00068613          	mv	a2,a3
     43c:	00158693          	addi	a3,a1,1
     440:	01869693          	slli	a3,a3,0x18
     444:	4186d693          	srai	a3,a3,0x18
     448:	01060793          	addi	a5,a2,16
     44c:	00278533          	add	a0,a5,sp
     450:	03041733          	mulh	a4,s0,a6
     454:	40275713          	srai	a4,a4,0x2
     458:	41f45793          	srai	a5,s0,0x1f
     45c:	40f70733          	sub	a4,a4,a5
     460:	00271793          	slli	a5,a4,0x2
     464:	00e787b3          	add	a5,a5,a4
     468:	00179793          	slli	a5,a5,0x1
     46c:	40f407b3          	sub	a5,s0,a5
     470:	03078793          	addi	a5,a5,48
     474:	fef50a23          	sb	a5,-12(a0)
     478:	00040793          	mv	a5,s0
     47c:	00070413          	mv	s0,a4
     480:	faf8cae3          	blt	a7,a5,434 <print_int+0x28>
     484:	04064063          	bltz	a2,4c4 <print_int+0xb8>
     488:	00912a23          	sw	s1,20(sp)
     48c:	01212823          	sw	s2,16(sp)
     490:	00410413          	addi	s0,sp,4
     494:	00c40433          	add	s0,s0,a2
     498:	00310493          	addi	s1,sp,3
     49c:	00c484b3          	add	s1,s1,a2
     4a0:	40b484b3          	sub	s1,s1,a1
     4a4:	00100913          	li	s2,1
     4a8:	00090593          	mv	a1,s2
     4ac:	00040513          	mv	a0,s0
     4b0:	36c010ef          	jal	181c <uart_write>
     4b4:	fff40413          	addi	s0,s0,-1
     4b8:	fe8498e3          	bne	s1,s0,4a8 <print_int+0x9c>
     4bc:	01412483          	lw	s1,20(sp)
     4c0:	01012903          	lw	s2,16(sp)
     4c4:	01c12083          	lw	ra,28(sp)
     4c8:	01812403          	lw	s0,24(sp)
     4cc:	02010113          	addi	sp,sp,32
     4d0:	00008067          	ret
     4d4:	00100593          	li	a1,1
     4d8:	00002537          	lui	a0,0x2
     4dc:	91c50513          	addi	a0,a0,-1764 # 191c <circ_buf_close+0x64>
     4e0:	33c010ef          	jal	181c <uart_write>
     4e4:	40800433          	neg	s0,s0
     4e8:	f3dff06f          	j	424 <print_int+0x18>
     4ec:	00100593          	li	a1,1
     4f0:	00002537          	lui	a0,0x2
     4f4:	92050513          	addi	a0,a0,-1760 # 1920 <circ_buf_close+0x68>
     4f8:	324010ef          	jal	181c <uart_write>
     4fc:	fc9ff06f          	j	4c4 <print_int+0xb8>

00000500 <print_float>:
     500:	fd010113          	addi	sp,sp,-48
     504:	02112623          	sw	ra,44(sp)
     508:	02812423          	sw	s0,40(sp)
     50c:	00812e27          	fsw	fs0,28(sp)
     510:	20a50453          	fmv.s	fs0,fa0
     514:	20a517d3          	fneg.s	fa5,fa0
     518:	c00797d3          	fcvt.w.s	a5,fa5,rtz
     51c:	d007f7d3          	fcvt.s.w	fa5,a5
     520:	00a7f7d3          	fadd.s	fa5,fa5,fa0
     524:	00002737          	lui	a4,0x2
     528:	bb872707          	flw	fa4,-1096(a4) # 1bb8 <circ_buf_close+0x300>
     52c:	10e7f7d3          	fmul.s	fa5,fa5,fa4
     530:	c0079453          	fcvt.w.s	s0,fa5,rtz
     534:	08044063          	bltz	s0,5b4 <print_float+0xb4>
     538:	c0041553          	fcvt.w.s	a0,fs0,rtz
     53c:	ed1ff0ef          	jal	40c <print_int>
     540:	00100593          	li	a1,1
     544:	00002537          	lui	a0,0x2
     548:	92450513          	addi	a0,a0,-1756 # 1924 <circ_buf_close+0x6c>
     54c:	2d0010ef          	jal	181c <uart_write>
     550:	00c10693          	addi	a3,sp,12
     554:	00810593          	addi	a1,sp,8
     558:	66666637          	lui	a2,0x66666
     55c:	66760613          	addi	a2,a2,1639 # 66666667 <_stack_start+0x6665e667>
     560:	02c41733          	mulh	a4,s0,a2
     564:	40275713          	srai	a4,a4,0x2
     568:	41f45793          	srai	a5,s0,0x1f
     56c:	40f70733          	sub	a4,a4,a5
     570:	00271793          	slli	a5,a4,0x2
     574:	00e787b3          	add	a5,a5,a4
     578:	00179793          	slli	a5,a5,0x1
     57c:	40f407b3          	sub	a5,s0,a5
     580:	03078793          	addi	a5,a5,48
     584:	00f681a3          	sb	a5,3(a3)
     588:	00070413          	mv	s0,a4
     58c:	fff68693          	addi	a3,a3,-1
     590:	fcb698e3          	bne	a3,a1,560 <print_float+0x60>
     594:	00400593          	li	a1,4
     598:	00c10513          	addi	a0,sp,12
     59c:	280010ef          	jal	181c <uart_write>
     5a0:	02c12083          	lw	ra,44(sp)
     5a4:	02812403          	lw	s0,40(sp)
     5a8:	01c12407          	flw	fs0,28(sp)
     5ac:	03010113          	addi	sp,sp,48
     5b0:	00008067          	ret
     5b4:	00078663          	beqz	a5,5c0 <print_float+0xc0>
     5b8:	40800433          	neg	s0,s0
     5bc:	f7dff06f          	j	538 <print_float+0x38>
     5c0:	00100593          	li	a1,1
     5c4:	00002537          	lui	a0,0x2
     5c8:	91c50513          	addi	a0,a0,-1764 # 191c <circ_buf_close+0x64>
     5cc:	250010ef          	jal	181c <uart_write>
     5d0:	fe9ff06f          	j	5b8 <print_float+0xb8>

000005d4 <uart_send_char>:
     5d4:	fe010113          	addi	sp,sp,-32
     5d8:	00112e23          	sw	ra,28(sp)
     5dc:	00a107a3          	sb	a0,15(sp)
     5e0:	00100593          	li	a1,1
     5e4:	00f10513          	addi	a0,sp,15
     5e8:	234010ef          	jal	181c <uart_write>
     5ec:	01c12083          	lw	ra,28(sp)
     5f0:	02010113          	addi	sp,sp,32
     5f4:	00008067          	ret

000005f8 <ee_printf>:
     5f8:	d9010113          	addi	sp,sp,-624
     5fc:	24112623          	sw	ra,588(sp)
     600:	24812423          	sw	s0,584(sp)
     604:	24b12a23          	sw	a1,596(sp)
     608:	24c12c23          	sw	a2,600(sp)
     60c:	24d12e23          	sw	a3,604(sp)
     610:	26e12023          	sw	a4,608(sp)
     614:	26f12223          	sw	a5,612(sp)
     618:	27012423          	sw	a6,616(sp)
     61c:	27112623          	sw	a7,620(sp)
     620:	25410793          	addi	a5,sp,596
     624:	00f12e23          	sw	a5,28(sp)
     628:	00054783          	lbu	a5,0(a0)
     62c:	02078ce3          	beqz	a5,e64 <ee_printf+0x86c>
     630:	24912223          	sw	s1,580(sp)
     634:	25212023          	sw	s2,576(sp)
     638:	23312e23          	sw	s3,572(sp)
     63c:	23412c23          	sw	s4,568(sp)
     640:	23512a23          	sw	s5,564(sp)
     644:	23612823          	sw	s6,560(sp)
     648:	00050313          	mv	t1,a0
     64c:	01c12983          	lw	s3,28(sp)
     650:	02010513          	addi	a0,sp,32
     654:	02500a13          	li	s4,37
     658:	01000493          	li	s1,16
     65c:	00002937          	lui	s2,0x2
     660:	93090913          	addi	s2,s2,-1744 # 1930 <circ_buf_close+0x78>
     664:	00900b13          	li	s6,9
     668:	02e00a93          	li	s5,46
     66c:	7680006f          	j	dd4 <ee_printf+0x7dc>
     670:	00000793          	li	a5,0
     674:	00c0006f          	j	680 <ee_printf+0x88>
     678:	0107e793          	ori	a5,a5,16
     67c:	00040313          	mv	t1,s0
     680:	00130413          	addi	s0,t1,1
     684:	00134603          	lbu	a2,1(t1)
     688:	fe060713          	addi	a4,a2,-32
     68c:	0ff77693          	zext.b	a3,a4
     690:	02d4ea63          	bltu	s1,a3,6c4 <ee_printf+0xcc>
     694:	00269713          	slli	a4,a3,0x2
     698:	01270733          	add	a4,a4,s2
     69c:	00072703          	lw	a4,0(a4)
     6a0:	00070067          	jr	a4
     6a4:	0047e793          	ori	a5,a5,4
     6a8:	fd5ff06f          	j	67c <ee_printf+0x84>
     6ac:	0087e793          	ori	a5,a5,8
     6b0:	fcdff06f          	j	67c <ee_printf+0x84>
     6b4:	0207e793          	ori	a5,a5,32
     6b8:	fc5ff06f          	j	67c <ee_printf+0x84>
     6bc:	0017e793          	ori	a5,a5,1
     6c0:	fbdff06f          	j	67c <ee_printf+0x84>
     6c4:	fd060713          	addi	a4,a2,-48
     6c8:	0ff77713          	zext.b	a4,a4
     6cc:	06eb7063          	bgeu	s6,a4,72c <ee_printf+0x134>
     6d0:	02a00713          	li	a4,42
     6d4:	fff00693          	li	a3,-1
     6d8:	08e60463          	beq	a2,a4,760 <ee_printf+0x168>
     6dc:	00044603          	lbu	a2,0(s0)
     6e0:	fff00713          	li	a4,-1
     6e4:	09560e63          	beq	a2,s5,780 <ee_printf+0x188>
     6e8:	00044603          	lbu	a2,0(s0)
     6ec:	0df67813          	andi	a6,a2,223
     6f0:	04c00593          	li	a1,76
     6f4:	7cb81263          	bne	a6,a1,eb8 <ee_printf+0x8c0>
     6f8:	00060e13          	mv	t3,a2
     6fc:	00140893          	addi	a7,s0,1
     700:	00144603          	lbu	a2,1(s0)
     704:	fbf60593          	addi	a1,a2,-65
     708:	0ff5f313          	zext.b	t1,a1
     70c:	03700813          	li	a6,55
     710:	66686863          	bltu	a6,t1,d80 <ee_printf+0x788>
     714:	00231593          	slli	a1,t1,0x2
     718:	00002837          	lui	a6,0x2
     71c:	97480813          	addi	a6,a6,-1676 # 1974 <circ_buf_close+0xbc>
     720:	010585b3          	add	a1,a1,a6
     724:	0005a583          	lw	a1,0(a1)
     728:	00058067          	jr	a1
     72c:	00000693          	li	a3,0
     730:	00900593          	li	a1,9
     734:	00140413          	addi	s0,s0,1
     738:	00269713          	slli	a4,a3,0x2
     73c:	00d70733          	add	a4,a4,a3
     740:	00171713          	slli	a4,a4,0x1
     744:	00c70733          	add	a4,a4,a2
     748:	fd070693          	addi	a3,a4,-48
     74c:	00044603          	lbu	a2,0(s0)
     750:	fd060713          	addi	a4,a2,-48
     754:	0ff77713          	zext.b	a4,a4
     758:	fce5fee3          	bgeu	a1,a4,734 <ee_printf+0x13c>
     75c:	f81ff06f          	j	6dc <ee_printf+0xe4>
     760:	00230413          	addi	s0,t1,2
     764:	00498713          	addi	a4,s3,4
     768:	0009a683          	lw	a3,0(s3)
     76c:	00070993          	mv	s3,a4
     770:	f606d6e3          	bgez	a3,6dc <ee_printf+0xe4>
     774:	40d006b3          	neg	a3,a3
     778:	0107e793          	ori	a5,a5,16
     77c:	f61ff06f          	j	6dc <ee_printf+0xe4>
     780:	00140813          	addi	a6,s0,1
     784:	00144583          	lbu	a1,1(s0)
     788:	fd058713          	addi	a4,a1,-48
     78c:	0ff77713          	zext.b	a4,a4
     790:	00900613          	li	a2,9
     794:	00e67c63          	bgeu	a2,a4,7ac <ee_printf+0x1b4>
     798:	02a00713          	li	a4,42
     79c:	04e58a63          	beq	a1,a4,7f0 <ee_printf+0x1f8>
     7a0:	00080413          	mv	s0,a6
     7a4:	00000713          	li	a4,0
     7a8:	f41ff06f          	j	6e8 <ee_printf+0xf0>
     7ac:	00000893          	li	a7,0
     7b0:	00060313          	mv	t1,a2
     7b4:	00180813          	addi	a6,a6,1
     7b8:	00289713          	slli	a4,a7,0x2
     7bc:	01170733          	add	a4,a4,a7
     7c0:	00171713          	slli	a4,a4,0x1
     7c4:	00b70733          	add	a4,a4,a1
     7c8:	fd070893          	addi	a7,a4,-48
     7cc:	00084583          	lbu	a1,0(a6)
     7d0:	fd058613          	addi	a2,a1,-48
     7d4:	0ff67613          	zext.b	a2,a2
     7d8:	fcc37ee3          	bgeu	t1,a2,7b4 <ee_printf+0x1bc>
     7dc:	fff8c613          	not	a2,a7
     7e0:	41f65613          	srai	a2,a2,0x1f
     7e4:	00c8f733          	and	a4,a7,a2
     7e8:	00080413          	mv	s0,a6
     7ec:	efdff06f          	j	6e8 <ee_printf+0xf0>
     7f0:	00240813          	addi	a6,s0,2
     7f4:	0009a883          	lw	a7,0(s3)
     7f8:	00498993          	addi	s3,s3,4
     7fc:	fe1ff06f          	j	7dc <ee_printf+0x1e4>
     800:	00088413          	mv	s0,a7
     804:	01000613          	li	a2,16
     808:	06c00593          	li	a1,108
     80c:	5abe0863          	beq	t3,a1,dbc <ee_printf+0x7c4>
     810:	0009a583          	lw	a1,0(s3)
     814:	00498993          	addi	s3,s3,4
     818:	5ac0006f          	j	dc4 <ee_printf+0x7cc>
     81c:	fff00e13          	li	t3,-1
     820:	fe5ff06f          	j	804 <ee_printf+0x20c>
     824:	00088413          	mv	s0,a7
     828:	0107f793          	andi	a5,a5,16
     82c:	04078463          	beqz	a5,874 <ee_printf+0x27c>
     830:	00498813          	addi	a6,s3,4
     834:	00150593          	addi	a1,a0,1
     838:	0009a783          	lw	a5,0(s3)
     83c:	00f50023          	sb	a5,0(a0)
     840:	00100793          	li	a5,1
     844:	5ad7da63          	bge	a5,a3,df8 <ee_printf+0x800>
     848:	00068613          	mv	a2,a3
     84c:	00d506b3          	add	a3,a0,a3
     850:	00058793          	mv	a5,a1
     854:	02000713          	li	a4,32
     858:	00178793          	addi	a5,a5,1
     85c:	fee78fa3          	sb	a4,-1(a5)
     860:	fed79ce3          	bne	a5,a3,858 <ee_printf+0x260>
     864:	fff60613          	addi	a2,a2,-1
     868:	00c58533          	add	a0,a1,a2
     86c:	00080993          	mv	s3,a6
     870:	5580006f          	j	dc8 <ee_printf+0x7d0>
     874:	00100713          	li	a4,1
     878:	60d75e63          	bge	a4,a3,e94 <ee_printf+0x89c>
     87c:	00068593          	mv	a1,a3
     880:	fff68693          	addi	a3,a3,-1
     884:	00d506b3          	add	a3,a0,a3
     888:	00050713          	mv	a4,a0
     88c:	02000613          	li	a2,32
     890:	00170713          	addi	a4,a4,1
     894:	fec70fa3          	sb	a2,-1(a4)
     898:	fed71ce3          	bne	a4,a3,890 <ee_printf+0x298>
     89c:	fff50513          	addi	a0,a0,-1
     8a0:	00b50533          	add	a0,a0,a1
     8a4:	00078693          	mv	a3,a5
     8a8:	f89ff06f          	j	830 <ee_printf+0x238>
     8ac:	00088413          	mv	s0,a7
     8b0:	00498813          	addi	a6,s3,4
     8b4:	0009a603          	lw	a2,0(s3)
     8b8:	08060a63          	beqz	a2,94c <ee_printf+0x354>
     8bc:	00064583          	lbu	a1,0(a2)
     8c0:	5e058463          	beqz	a1,ea8 <ee_printf+0x8b0>
     8c4:	00e608b3          	add	a7,a2,a4
     8c8:	00060713          	mv	a4,a2
     8cc:	01170a63          	beq	a4,a7,8e0 <ee_printf+0x2e8>
     8d0:	00170713          	addi	a4,a4,1
     8d4:	00074583          	lbu	a1,0(a4)
     8d8:	fe059ae3          	bnez	a1,8cc <ee_printf+0x2d4>
     8dc:	00070893          	mv	a7,a4
     8e0:	40c888b3          	sub	a7,a7,a2
     8e4:	0107f793          	andi	a5,a5,16
     8e8:	06078863          	beqz	a5,958 <ee_printf+0x360>
     8ec:	03105463          	blez	a7,914 <ee_printf+0x31c>
     8f0:	00088313          	mv	t1,a7
     8f4:	011605b3          	add	a1,a2,a7
     8f8:	00050793          	mv	a5,a0
     8fc:	00160613          	addi	a2,a2,1
     900:	00178793          	addi	a5,a5,1
     904:	fff64703          	lbu	a4,-1(a2)
     908:	fee78fa3          	sb	a4,-1(a5)
     90c:	feb618e3          	bne	a2,a1,8fc <ee_printf+0x304>
     910:	00650533          	add	a0,a0,t1
     914:	4ed8d863          	bge	a7,a3,e04 <ee_printf+0x80c>
     918:	00068613          	mv	a2,a3
     91c:	00088593          	mv	a1,a7
     920:	411688b3          	sub	a7,a3,a7
     924:	01150733          	add	a4,a0,a7
     928:	00050793          	mv	a5,a0
     92c:	02000693          	li	a3,32
     930:	00178793          	addi	a5,a5,1
     934:	fed78fa3          	sb	a3,-1(a5)
     938:	fee79ce3          	bne	a5,a4,930 <ee_printf+0x338>
     93c:	00c50633          	add	a2,a0,a2
     940:	40b60533          	sub	a0,a2,a1
     944:	00080993          	mv	s3,a6
     948:	4800006f          	j	dc8 <ee_printf+0x7d0>
     94c:	00002637          	lui	a2,0x2
     950:	92860613          	addi	a2,a2,-1752 # 1928 <circ_buf_close+0x70>
     954:	f71ff06f          	j	8c4 <ee_printf+0x2cc>
     958:	fff68593          	addi	a1,a3,-1
     95c:	02d8de63          	bge	a7,a3,998 <ee_printf+0x3a0>
     960:	00068313          	mv	t1,a3
     964:	00088e13          	mv	t3,a7
     968:	41168733          	sub	a4,a3,a7
     96c:	00e50733          	add	a4,a0,a4
     970:	00050793          	mv	a5,a0
     974:	02000693          	li	a3,32
     978:	00178793          	addi	a5,a5,1
     97c:	fed78fa3          	sb	a3,-1(a5)
     980:	fee79ce3          	bne	a5,a4,978 <ee_printf+0x380>
     984:	406585b3          	sub	a1,a1,t1
     988:	01c586b3          	add	a3,a1,t3
     98c:	00650333          	add	t1,a0,t1
     990:	41c30533          	sub	a0,t1,t3
     994:	f59ff06f          	j	8ec <ee_printf+0x2f4>
     998:	00058693          	mv	a3,a1
     99c:	f51ff06f          	j	8ec <ee_printf+0x2f4>
     9a0:	23712623          	sw	s7,556(sp)
     9a4:	00088413          	mv	s0,a7
     9a8:	fff00613          	li	a2,-1
     9ac:	02c68463          	beq	a3,a2,9d4 <ee_printf+0x3dc>
     9b0:	00498b93          	addi	s7,s3,4
     9b4:	01000613          	li	a2,16
     9b8:	0009a583          	lw	a1,0(s3)
     9bc:	e5cff0ef          	jal	18 <number>
     9c0:	000b8993          	mv	s3,s7
     9c4:	22c12b83          	lw	s7,556(sp)
     9c8:	4000006f          	j	dc8 <ee_printf+0x7d0>
     9cc:	23712623          	sw	s7,556(sp)
     9d0:	fd9ff06f          	j	9a8 <ee_printf+0x3b0>
     9d4:	0017e793          	ori	a5,a5,1
     9d8:	00800693          	li	a3,8
     9dc:	fd5ff06f          	j	9b0 <ee_printf+0x3b8>
     9e0:	00088413          	mv	s0,a7
     9e4:	0407e793          	ori	a5,a5,64
     9e8:	06c00713          	li	a4,108
     9ec:	48ee0a63          	beq	t3,a4,e80 <ee_printf+0x888>
     9f0:	23712623          	sw	s7,556(sp)
     9f4:	00498713          	addi	a4,s3,4
     9f8:	00070b93          	mv	s7,a4
     9fc:	0009ae83          	lw	t4,0(s3)
     a00:	00000813          	li	a6,0
     a04:	00000593          	li	a1,0
     a08:	06300293          	li	t0,99
     a0c:	00002e37          	lui	t3,0x2
     a10:	8cce0e13          	addi	t3,t3,-1844 # 18cc <circ_buf_close+0x14>
     a14:	03000f93          	li	t6,48
     a18:	00400313          	li	t1,4
     a1c:	02e00f13          	li	t5,46
     a20:	1f80006f          	j	c18 <ee_printf+0x620>
     a24:	fff00e13          	li	t3,-1
     a28:	fbdff06f          	j	9e4 <ee_printf+0x3ec>
     a2c:	06c00713          	li	a4,108
     a30:	10ee1a63          	bne	t3,a4,b44 <ee_printf+0x54c>
     a34:	0009a303          	lw	t1,0(s3)
     a38:	00498993          	addi	s3,s3,4
     a3c:	00088413          	mv	s0,a7
     a40:	000028b7          	lui	a7,0x2
     a44:	8cc88893          	addi	a7,a7,-1844 # 18cc <circ_buf_close+0x14>
     a48:	00000613          	li	a2,0
     a4c:	00000e13          	li	t3,0
     a50:	00600e93          	li	t4,6
     a54:	03a00f13          	li	t5,58
     a58:	0080006f          	j	a60 <ee_printf+0x468>
     a5c:	00080e13          	mv	t3,a6
     a60:	00c30733          	add	a4,t1,a2
     a64:	00074703          	lbu	a4,0(a4)
     a68:	00475593          	srli	a1,a4,0x4
     a6c:	00b885b3          	add	a1,a7,a1
     a70:	0005c803          	lbu	a6,0(a1)
     a74:	220e0593          	addi	a1,t3,544
     a78:	002585b3          	add	a1,a1,sp
     a7c:	df058223          	sb	a6,-540(a1)
     a80:	002e0813          	addi	a6,t3,2
     a84:	00f77713          	andi	a4,a4,15
     a88:	00e88733          	add	a4,a7,a4
     a8c:	00074703          	lbu	a4,0(a4)
     a90:	dee582a3          	sb	a4,-539(a1)
     a94:	00160613          	addi	a2,a2,1
     a98:	01d60e63          	beq	a2,t4,ab4 <ee_printf+0x4bc>
     a9c:	fc0600e3          	beqz	a2,a5c <ee_printf+0x464>
     aa0:	003e0e13          	addi	t3,t3,3
     aa4:	22080713          	addi	a4,a6,544
     aa8:	00270733          	add	a4,a4,sp
     aac:	dfe70223          	sb	t5,-540(a4)
     ab0:	fb1ff06f          	j	a60 <ee_printf+0x468>
     ab4:	0107f793          	andi	a5,a5,16
     ab8:	02079a63          	bnez	a5,aec <ee_printf+0x4f4>
     abc:	08d85063          	bge	a6,a3,b3c <ee_printf+0x544>
     ac0:	00068613          	mv	a2,a3
     ac4:	41068733          	sub	a4,a3,a6
     ac8:	00e50733          	add	a4,a0,a4
     acc:	00050793          	mv	a5,a0
     ad0:	02000693          	li	a3,32
     ad4:	00178793          	addi	a5,a5,1
     ad8:	fed78fa3          	sb	a3,-1(a5)
     adc:	fee79ce3          	bne	a5,a4,ad4 <ee_printf+0x4dc>
     ae0:	001e0693          	addi	a3,t3,1
     ae4:	00c50633          	add	a2,a0,a2
     ae8:	41060533          	sub	a0,a2,a6
     aec:	03005463          	blez	a6,b14 <ee_printf+0x51c>
     af0:	00410713          	addi	a4,sp,4
     af4:	010505b3          	add	a1,a0,a6
     af8:	00050793          	mv	a5,a0
     afc:	00178793          	addi	a5,a5,1
     b00:	00074603          	lbu	a2,0(a4)
     b04:	fec78fa3          	sb	a2,-1(a5)
     b08:	00170713          	addi	a4,a4,1
     b0c:	feb798e3          	bne	a5,a1,afc <ee_printf+0x504>
     b10:	01050533          	add	a0,a0,a6
     b14:	2ad85a63          	bge	a6,a3,dc8 <ee_printf+0x7d0>
     b18:	41068733          	sub	a4,a3,a6
     b1c:	00e50633          	add	a2,a0,a4
     b20:	00050793          	mv	a5,a0
     b24:	02000693          	li	a3,32
     b28:	00178793          	addi	a5,a5,1
     b2c:	fed78fa3          	sb	a3,-1(a5)
     b30:	fec79ce3          	bne	a5,a2,b28 <ee_printf+0x530>
     b34:	00e50533          	add	a0,a0,a4
     b38:	2900006f          	j	dc8 <ee_printf+0x7d0>
     b3c:	fff68693          	addi	a3,a3,-1
     b40:	fadff06f          	j	aec <ee_printf+0x4f4>
     b44:	23712623          	sw	s7,556(sp)
     b48:	00088413          	mv	s0,a7
     b4c:	ea9ff06f          	j	9f4 <ee_printf+0x3fc>
     b50:	23712623          	sw	s7,556(sp)
     b54:	ea1ff06f          	j	9f4 <ee_printf+0x3fc>
     b58:	00060593          	mv	a1,a2
     b5c:	0bc0006f          	j	c18 <ee_printf+0x620>
     b60:	0ce2dc63          	bge	t0,a4,c38 <ee_printf+0x640>
     b64:	22058613          	addi	a2,a1,544
     b68:	002608b3          	add	a7,a2,sp
     b6c:	51eb8637          	lui	a2,0x51eb8
     b70:	51f60613          	addi	a2,a2,1311 # 51eb851f <_stack_start+0x51eb051f>
     b74:	02c71633          	mulh	a2,a4,a2
     b78:	40565613          	srai	a2,a2,0x5
     b7c:	41f75393          	srai	t2,a4,0x1f
     b80:	40760633          	sub	a2,a2,t2
     b84:	000023b7          	lui	t2,0x2
     b88:	8cc38393          	addi	t2,t2,-1844 # 18cc <circ_buf_close+0x14>
     b8c:	007609b3          	add	s3,a2,t2
     b90:	0009c983          	lbu	s3,0(s3)
     b94:	df388223          	sb	s3,-540(a7)
     b98:	06400893          	li	a7,100
     b9c:	03160633          	mul	a2,a2,a7
     ba0:	40c70633          	sub	a2,a4,a2
     ba4:	22158713          	addi	a4,a1,545
     ba8:	002709b3          	add	s3,a4,sp
     bac:	00258593          	addi	a1,a1,2
     bb0:	66666737          	lui	a4,0x66666
     bb4:	66770713          	addi	a4,a4,1639 # 66666667 <_stack_start+0x6665e667>
     bb8:	02e61733          	mulh	a4,a2,a4
     bbc:	40275713          	srai	a4,a4,0x2
     bc0:	41f65893          	srai	a7,a2,0x1f
     bc4:	41170733          	sub	a4,a4,a7
     bc8:	007703b3          	add	t2,a4,t2
     bcc:	0003c383          	lbu	t2,0(t2)
     bd0:	de798223          	sb	t2,-540(s3)
     bd4:	00271393          	slli	t2,a4,0x2
     bd8:	00e38733          	add	a4,t2,a4
     bdc:	00171713          	slli	a4,a4,0x1
     be0:	40e60733          	sub	a4,a2,a4
     be4:	00158613          	addi	a2,a1,1
     be8:	22058593          	addi	a1,a1,544
     bec:	002585b3          	add	a1,a1,sp
     bf0:	01c70733          	add	a4,a4,t3
     bf4:	00074703          	lbu	a4,0(a4)
     bf8:	dee58223          	sb	a4,-540(a1)
     bfc:	00180813          	addi	a6,a6,1
     c00:	08680663          	beq	a6,t1,c8c <ee_printf+0x694>
     c04:	f4080ae3          	beqz	a6,b58 <ee_printf+0x560>
     c08:	00160593          	addi	a1,a2,1
     c0c:	22060713          	addi	a4,a2,544
     c10:	00270633          	add	a2,a4,sp
     c14:	dfe60223          	sb	t5,-540(a2)
     c18:	010e8733          	add	a4,t4,a6
     c1c:	00074703          	lbu	a4,0(a4)
     c20:	f40710e3          	bnez	a4,b60 <ee_printf+0x568>
     c24:	00158613          	addi	a2,a1,1
     c28:	22058713          	addi	a4,a1,544
     c2c:	002705b3          	add	a1,a4,sp
     c30:	dff58223          	sb	t6,-540(a1)
     c34:	fc9ff06f          	j	bfc <ee_printf+0x604>
     c38:	00900613          	li	a2,9
     c3c:	fae654e3          	bge	a2,a4,be4 <ee_printf+0x5ec>
     c40:	22058613          	addi	a2,a1,544
     c44:	002609b3          	add	s3,a2,sp
     c48:	66666637          	lui	a2,0x66666
     c4c:	66760613          	addi	a2,a2,1639 # 66666667 <_stack_start+0x6665e667>
     c50:	02c71633          	mulh	a2,a4,a2
     c54:	40265613          	srai	a2,a2,0x2
     c58:	41f75393          	srai	t2,a4,0x1f
     c5c:	40760633          	sub	a2,a2,t2
     c60:	000023b7          	lui	t2,0x2
     c64:	8cc38393          	addi	t2,t2,-1844 # 18cc <circ_buf_close+0x14>
     c68:	007603b3          	add	t2,a2,t2
     c6c:	0003c383          	lbu	t2,0(t2)
     c70:	de798223          	sb	t2,-540(s3)
     c74:	00261393          	slli	t2,a2,0x2
     c78:	00c38633          	add	a2,t2,a2
     c7c:	00161613          	slli	a2,a2,0x1
     c80:	40c70733          	sub	a4,a4,a2
     c84:	00158593          	addi	a1,a1,1
     c88:	f5dff06f          	j	be4 <ee_printf+0x5ec>
     c8c:	0107f793          	andi	a5,a5,16
     c90:	02079c63          	bnez	a5,cc8 <ee_printf+0x6d0>
     c94:	08d65863          	bge	a2,a3,d24 <ee_printf+0x72c>
     c98:	00068593          	mv	a1,a3
     c9c:	00060813          	mv	a6,a2
     ca0:	40c68733          	sub	a4,a3,a2
     ca4:	00e50733          	add	a4,a0,a4
     ca8:	00050793          	mv	a5,a0
     cac:	02000693          	li	a3,32
     cb0:	00178793          	addi	a5,a5,1
     cb4:	fed78fa3          	sb	a3,-1(a5)
     cb8:	fee79ce3          	bne	a5,a4,cb0 <ee_printf+0x6b8>
     cbc:	fff80693          	addi	a3,a6,-1
     cc0:	00b505b3          	add	a1,a0,a1
     cc4:	41058533          	sub	a0,a1,a6
     cc8:	02c05663          	blez	a2,cf4 <ee_printf+0x6fc>
     ccc:	00410713          	addi	a4,sp,4
     cd0:	00060313          	mv	t1,a2
     cd4:	00c50833          	add	a6,a0,a2
     cd8:	00050793          	mv	a5,a0
     cdc:	00178793          	addi	a5,a5,1
     ce0:	00074583          	lbu	a1,0(a4)
     ce4:	feb78fa3          	sb	a1,-1(a5)
     ce8:	00170713          	addi	a4,a4,1
     cec:	ff0798e3          	bne	a5,a6,cdc <ee_printf+0x6e4>
     cf0:	00650533          	add	a0,a0,t1
     cf4:	02d65263          	bge	a2,a3,d18 <ee_printf+0x720>
     cf8:	40c68633          	sub	a2,a3,a2
     cfc:	00c506b3          	add	a3,a0,a2
     d00:	00050793          	mv	a5,a0
     d04:	02000713          	li	a4,32
     d08:	00178793          	addi	a5,a5,1
     d0c:	fee78fa3          	sb	a4,-1(a5)
     d10:	fed79ce3          	bne	a5,a3,d08 <ee_printf+0x710>
     d14:	00c50533          	add	a0,a0,a2
     d18:	000b8993          	mv	s3,s7
     d1c:	22c12b83          	lw	s7,556(sp)
     d20:	0a80006f          	j	dc8 <ee_printf+0x7d0>
     d24:	fff68693          	addi	a3,a3,-1
     d28:	fa1ff06f          	j	cc8 <ee_printf+0x6d0>
     d2c:	00088413          	mv	s0,a7
     d30:	00800613          	li	a2,8
     d34:	ad5ff06f          	j	808 <ee_printf+0x210>
     d38:	fff00e13          	li	t3,-1
     d3c:	ff5ff06f          	j	d30 <ee_printf+0x738>
     d40:	00088413          	mv	s0,a7
     d44:	0407e793          	ori	a5,a5,64
     d48:	01000613          	li	a2,16
     d4c:	abdff06f          	j	808 <ee_printf+0x210>
     d50:	fff00e13          	li	t3,-1
     d54:	ff1ff06f          	j	d44 <ee_printf+0x74c>
     d58:	00088413          	mv	s0,a7
     d5c:	0027e793          	ori	a5,a5,2
     d60:	06c00613          	li	a2,108
     d64:	08ce0663          	beq	t3,a2,df0 <ee_printf+0x7f8>
     d68:	0009a583          	lw	a1,0(s3)
     d6c:	00498993          	addi	s3,s3,4
     d70:	00a00613          	li	a2,10
     d74:	0500006f          	j	dc4 <ee_printf+0x7cc>
     d78:	fff00e13          	li	t3,-1
     d7c:	fe1ff06f          	j	d5c <ee_printf+0x764>
     d80:	00088413          	mv	s0,a7
     d84:	02500793          	li	a5,37
     d88:	0ef60263          	beq	a2,a5,e6c <ee_printf+0x874>
     d8c:	00150793          	addi	a5,a0,1
     d90:	02500713          	li	a4,37
     d94:	00e50023          	sb	a4,0(a0)
     d98:	00044703          	lbu	a4,0(s0)
     d9c:	0c071c63          	bnez	a4,e74 <ee_printf+0x87c>
     da0:	fff40413          	addi	s0,s0,-1
     da4:	00078513          	mv	a0,a5
     da8:	0200006f          	j	dc8 <ee_printf+0x7d0>
     dac:	00088413          	mv	s0,a7
     db0:	06c00593          	li	a1,108
     db4:	00a00613          	li	a2,10
     db8:	a4be1ce3          	bne	t3,a1,810 <ee_printf+0x218>
     dbc:	0009a583          	lw	a1,0(s3)
     dc0:	00498993          	addi	s3,s3,4
     dc4:	a54ff0ef          	jal	18 <number>
     dc8:	00140313          	addi	t1,s0,1
     dcc:	00144783          	lbu	a5,1(s0)
     dd0:	02078e63          	beqz	a5,e0c <ee_printf+0x814>
     dd4:	89478ee3          	beq	a5,s4,670 <ee_printf+0x78>
     dd8:	00f50023          	sb	a5,0(a0)
     ddc:	00030413          	mv	s0,t1
     de0:	00150513          	addi	a0,a0,1
     de4:	fe5ff06f          	j	dc8 <ee_printf+0x7d0>
     de8:	fff00e13          	li	t3,-1
     dec:	fc5ff06f          	j	db0 <ee_printf+0x7b8>
     df0:	00a00613          	li	a2,10
     df4:	fc9ff06f          	j	dbc <ee_printf+0x7c4>
     df8:	00080993          	mv	s3,a6
     dfc:	00058513          	mv	a0,a1
     e00:	fc9ff06f          	j	dc8 <ee_printf+0x7d0>
     e04:	00080993          	mv	s3,a6
     e08:	fc1ff06f          	j	dc8 <ee_printf+0x7d0>
     e0c:	24412483          	lw	s1,580(sp)
     e10:	24012903          	lw	s2,576(sp)
     e14:	23c12983          	lw	s3,572(sp)
     e18:	23812a03          	lw	s4,568(sp)
     e1c:	23412a83          	lw	s5,564(sp)
     e20:	23012b03          	lw	s6,560(sp)
     e24:	00050023          	sb	zero,0(a0)
     e28:	02014503          	lbu	a0,32(sp)
     e2c:	02050463          	beqz	a0,e54 <ee_printf+0x85c>
     e30:	02010413          	addi	s0,sp,32
     e34:	fa0ff0ef          	jal	5d4 <uart_send_char>
     e38:	00040793          	mv	a5,s0
     e3c:	00140413          	addi	s0,s0,1
     e40:	00044503          	lbu	a0,0(s0)
     e44:	fe0518e3          	bnez	a0,e34 <ee_printf+0x83c>
     e48:	22010713          	addi	a4,sp,544
     e4c:	40e78533          	sub	a0,a5,a4
     e50:	20150513          	addi	a0,a0,513
     e54:	24c12083          	lw	ra,588(sp)
     e58:	24812403          	lw	s0,584(sp)
     e5c:	27010113          	addi	sp,sp,624
     e60:	00008067          	ret
     e64:	02010513          	addi	a0,sp,32
     e68:	fbdff06f          	j	e24 <ee_printf+0x82c>
     e6c:	00044703          	lbu	a4,0(s0)
     e70:	00050793          	mv	a5,a0
     e74:	00178513          	addi	a0,a5,1
     e78:	00e78023          	sb	a4,0(a5)
     e7c:	f4dff06f          	j	dc8 <ee_printf+0x7d0>
     e80:	0009a303          	lw	t1,0(s3)
     e84:	00498993          	addi	s3,s3,4
     e88:	000028b7          	lui	a7,0x2
     e8c:	8f488893          	addi	a7,a7,-1804 # 18f4 <circ_buf_close+0x3c>
     e90:	bb9ff06f          	j	a48 <ee_printf+0x450>
     e94:	0009a783          	lw	a5,0(s3)
     e98:	00f50023          	sb	a5,0(a0)
     e9c:	00498993          	addi	s3,s3,4
     ea0:	00150513          	addi	a0,a0,1
     ea4:	f25ff06f          	j	dc8 <ee_printf+0x7d0>
     ea8:	0107f893          	andi	a7,a5,16
     eac:	02088a63          	beqz	a7,ee0 <ee_printf+0x8e8>
     eb0:	00000893          	li	a7,0
     eb4:	a61ff06f          	j	914 <ee_printf+0x31c>
     eb8:	fbf60593          	addi	a1,a2,-65
     ebc:	0ff5f893          	zext.b	a7,a1
     ec0:	03700813          	li	a6,55
     ec4:	ed1860e3          	bltu	a6,a7,d84 <ee_printf+0x78c>
     ec8:	00289593          	slli	a1,a7,0x2
     ecc:	00002837          	lui	a6,0x2
     ed0:	a5480813          	addi	a6,a6,-1452 # 1a54 <circ_buf_close+0x19c>
     ed4:	010585b3          	add	a1,a1,a6
     ed8:	0005a583          	lw	a1,0(a1)
     edc:	00058067          	jr	a1
     ee0:	fff68593          	addi	a1,a3,-1
     ee4:	a6d04ee3          	bgtz	a3,960 <ee_printf+0x368>
     ee8:	00058693          	mv	a3,a1
     eec:	a29ff06f          	j	914 <ee_printf+0x31c>

00000ef0 <sine_from_rads_interp>:
     ef0:	c00517d3          	fcvt.w.s	a5,fa0,rtz
     ef4:	0007dc63          	bgez	a5,f0c <sine_from_rads_interp+0x1c>
     ef8:	000027b7          	lui	a5,0x2
     efc:	bac7a787          	flw	fa5,-1108(a5) # 1bac <circ_buf_close+0x2f4>
     f00:	00f57553          	fadd.s	fa0,fa0,fa5
     f04:	c00517d3          	fcvt.w.s	a5,fa0,rtz
     f08:	fe07cce3          	bltz	a5,f00 <sine_from_rads_interp+0x10>
     f0c:	000027b7          	lui	a5,0x2
     f10:	bb07a787          	flw	fa5,-1104(a5) # 1bb0 <circ_buf_close+0x2f8>
     f14:	10f577d3          	fmul.s	fa5,fa0,fa5
     f18:	c0079753          	fcvt.w.s	a4,fa5,rtz
     f1c:	03d00793          	li	a5,61
     f20:	02e7d463          	bge	a5,a4,f48 <sine_from_rads_interp+0x58>
     f24:	000027b7          	lui	a5,0x2
     f28:	c047a687          	flw	fa3,-1020(a5) # 1c04 <MINUS_TWO_PI>
     f2c:	000027b7          	lui	a5,0x2
     f30:	bb07a707          	flw	fa4,-1104(a5) # 1bb0 <circ_buf_close+0x2f8>
     f34:	03d00713          	li	a4,61
     f38:	00d57553          	fadd.s	fa0,fa0,fa3
     f3c:	10e577d3          	fmul.s	fa5,fa0,fa4
     f40:	c00797d3          	fcvt.w.s	a5,fa5,rtz
     f44:	fef74ae3          	blt	a4,a5,f38 <sine_from_rads_interp+0x48>
     f48:	000027b7          	lui	a5,0x2
     f4c:	bac7a787          	flw	fa5,-1108(a5) # 1bac <circ_buf_close+0x2f4>
     f50:	18f57553          	fdiv.s	fa0,fa0,fa5
     f54:	000027b7          	lui	a5,0x2
     f58:	bb47a787          	flw	fa5,-1100(a5) # 1bb4 <circ_buf_close+0x2fc>
     f5c:	10f57553          	fmul.s	fa0,fa0,fa5
     f60:	000027b7          	lui	a5,0x2
     f64:	bbc7a787          	flw	fa5,-1092(a5) # 1bbc <circ_buf_close+0x304>
     f68:	00f577d3          	fadd.s	fa5,fa0,fa5
     f6c:	c01797d3          	fcvt.wu.s	a5,fa5,rtz
     f70:	0ff7f793          	zext.b	a5,a5
     f74:	00002737          	lui	a4,0x2
     f78:	c0870713          	addi	a4,a4,-1016 # 1c08 <cosine_table>
     f7c:	00179693          	slli	a3,a5,0x1
     f80:	00d706b3          	add	a3,a4,a3
     f84:	00069603          	lh	a2,0(a3)
     f88:	04178693          	addi	a3,a5,65
     f8c:	0ff6f693          	zext.b	a3,a3
     f90:	00169693          	slli	a3,a3,0x1
     f94:	00d70733          	add	a4,a4,a3
     f98:	00071703          	lh	a4,0(a4)
     f9c:	40c70733          	sub	a4,a4,a2
     fa0:	d00777d3          	fcvt.s.w	fa5,a4
     fa4:	40f007b3          	neg	a5,a5
     fa8:	d007f753          	fcvt.s.w	fa4,a5
     fac:	00a77753          	fadd.s	fa4,fa4,fa0
     fb0:	10e7f7d3          	fmul.s	fa5,fa5,fa4
     fb4:	d0067553          	fcvt.s.w	fa0,a2
     fb8:	00a7f553          	fadd.s	fa0,fa5,fa0
     fbc:	00008067          	ret

00000fc0 <atan_approx>:
     fc0:	c0151753          	fcvt.wu.s	a4,fa0,rtz
     fc4:	00100793          	li	a5,1
     fc8:	02e7e463          	bltu	a5,a4,ff0 <atan_approx+0x30>
     fcc:	000027b7          	lui	a5,0x2
     fd0:	bc47a787          	flw	fa5,-1084(a5) # 1bc4 <circ_buf_close+0x30c>
     fd4:	10f577d3          	fmul.s	fa5,fa0,fa5
     fd8:	10a7f7d3          	fmul.s	fa5,fa5,fa0
     fdc:	000027b7          	lui	a5,0x2
     fe0:	bcc7a707          	flw	fa4,-1076(a5) # 1bcc <circ_buf_close+0x314>
     fe4:	00e7f7d3          	fadd.s	fa5,fa5,fa4
     fe8:	18f57553          	fdiv.s	fa0,fa0,fa5
     fec:	00008067          	ret
     ff0:	10a577d3          	fmul.s	fa5,fa0,fa0
     ff4:	000027b7          	lui	a5,0x2
     ff8:	bc47a707          	flw	fa4,-1084(a5) # 1bc4 <circ_buf_close+0x30c>
     ffc:	00e7f7d3          	fadd.s	fa5,fa5,fa4
    1000:	18f57553          	fdiv.s	fa0,fa0,fa5
    1004:	000027b7          	lui	a5,0x2
    1008:	bc07a787          	flw	fa5,-1088(a5) # 1bc0 <circ_buf_close+0x308>
    100c:	10f57553          	fmul.s	fa0,fa0,fa5
    1010:	000027b7          	lui	a5,0x2
    1014:	bc87a787          	flw	fa5,-1080(a5) # 1bc8 <circ_buf_close+0x310>
    1018:	00a7f553          	fadd.s	fa0,fa5,fa0
    101c:	00008067          	ret

00001020 <log_approx>:
    1020:	000027b7          	lui	a5,0x2
    1024:	bd07a787          	flw	fa5,-1072(a5) # 1bd0 <circ_buf_close+0x318>
    1028:	10f577d3          	fmul.s	fa5,fa0,fa5
    102c:	c0079753          	fcvt.w.s	a4,fa5,rtz
    1030:	7d000793          	li	a5,2000
    1034:	0ee7d063          	bge	a5,a4,1114 <log_approx+0xf4>
    1038:	00000793          	li	a5,0
    103c:	00002737          	lui	a4,0x2
    1040:	bd472687          	flw	fa3,-1068(a4) # 1bd4 <circ_buf_close+0x31c>
    1044:	00002737          	lui	a4,0x2
    1048:	bd072707          	flw	fa4,-1072(a4) # 1bd0 <circ_buf_close+0x318>
    104c:	7d000693          	li	a3,2000
    1050:	10d57553          	fmul.s	fa0,fa0,fa3
    1054:	00178793          	addi	a5,a5,1
    1058:	10e577d3          	fmul.s	fa5,fa0,fa4
    105c:	c0079753          	fcvt.w.s	a4,fa5,rtz
    1060:	fee6c8e3          	blt	a3,a4,1050 <log_approx+0x30>
    1064:	00002737          	lui	a4,0x2
    1068:	bd072787          	flw	fa5,-1072(a4) # 1bd0 <circ_buf_close+0x318>
    106c:	10f577d3          	fmul.s	fa5,fa0,fa5
    1070:	c00796d3          	fcvt.w.s	a3,fa5,rtz
    1074:	3e700713          	li	a4,999
    1078:	02d74263          	blt	a4,a3,109c <log_approx+0x7c>
    107c:	00002737          	lui	a4,0x2
    1080:	bd072707          	flw	fa4,-1072(a4) # 1bd0 <circ_buf_close+0x318>
    1084:	3e700693          	li	a3,999
    1088:	00a57553          	fadd.s	fa0,fa0,fa0
    108c:	fff78793          	addi	a5,a5,-1
    1090:	10e577d3          	fmul.s	fa5,fa0,fa4
    1094:	c0079753          	fcvt.w.s	a4,fa5,rtz
    1098:	fee6d8e3          	bge	a3,a4,1088 <log_approx+0x68>
    109c:	00002737          	lui	a4,0x2
    10a0:	bc072687          	flw	fa3,-1088(a4) # 1bc0 <circ_buf_close+0x308>
    10a4:	00002737          	lui	a4,0x2
    10a8:	bcc72787          	flw	fa5,-1076(a4) # 1bcc <circ_buf_close+0x314>
    10ac:	10d7f7d3          	fmul.s	fa5,fa5,fa3
    10b0:	00f57553          	fadd.s	fa0,fa0,fa5
    10b4:	10a57753          	fmul.s	fa4,fa0,fa0
    10b8:	10a77753          	fmul.s	fa4,fa4,fa0
    10bc:	00002737          	lui	a4,0x2
    10c0:	bd472787          	flw	fa5,-1068(a4) # 1bd4 <circ_buf_close+0x31c>
    10c4:	10f577d3          	fmul.s	fa5,fa0,fa5
    10c8:	10a7f7d3          	fmul.s	fa5,fa5,fa0
    10cc:	00002737          	lui	a4,0x2
    10d0:	bd872607          	flw	fa2,-1064(a4) # 1bd8 <circ_buf_close+0x320>
    10d4:	18c77653          	fdiv.s	fa2,fa4,fa2
    10d8:	00c7f7d3          	fadd.s	fa5,fa5,fa2
    10dc:	10d7f7d3          	fmul.s	fa5,fa5,fa3
    10e0:	00f577d3          	fadd.s	fa5,fa0,fa5
    10e4:	10a77753          	fmul.s	fa4,fa4,fa0
    10e8:	00002737          	lui	a4,0x2
    10ec:	bdc72607          	flw	fa2,-1060(a4) # 1bdc <circ_buf_close+0x324>
    10f0:	10c77753          	fmul.s	fa4,fa4,fa2
    10f4:	10d77753          	fmul.s	fa4,fa4,fa3
    10f8:	00e7f7d3          	fadd.s	fa5,fa5,fa4
    10fc:	d007f553          	fcvt.s.w	fa0,a5
    1100:	000027b7          	lui	a5,0x2
    1104:	be07a707          	flw	fa4,-1056(a5) # 1be0 <circ_buf_close+0x328>
    1108:	10e57553          	fmul.s	fa0,fa0,fa4
    110c:	00f57553          	fadd.s	fa0,fa0,fa5
    1110:	00008067          	ret
    1114:	00000793          	li	a5,0
    1118:	f4dff06f          	j	1064 <log_approx+0x44>

0000111c <exp_approx>:
    111c:	20a506d3          	fmv.s	fa3,fa0
    1120:	00100793          	li	a5,1
    1124:	00002737          	lui	a4,0x2
    1128:	bcc72707          	flw	fa4,-1076(a4) # 1bcc <circ_buf_close+0x314>
    112c:	20e70553          	fmv.s	fa0,fa4
    1130:	00b00713          	li	a4,11
    1134:	d007f7d3          	fcvt.s.w	fa5,a5
    1138:	18f6f7d3          	fdiv.s	fa5,fa3,fa5
    113c:	10f77753          	fmul.s	fa4,fa4,fa5
    1140:	00e57553          	fadd.s	fa0,fa0,fa4
    1144:	00178793          	addi	a5,a5,1
    1148:	fee796e3          	bne	a5,a4,1134 <exp_approx+0x18>
    114c:	00008067          	ret

00001150 <sqrt_newton>:
    1150:	20a507d3          	fmv.s	fa5,fa0
    1154:	000027b7          	lui	a5,0x2
    1158:	bb87a707          	flw	fa4,-1096(a5) # 1bb8 <circ_buf_close+0x300>
    115c:	10e57753          	fmul.s	fa4,fa0,fa4
    1160:	c01717d3          	fcvt.wu.s	a5,fa4,rtz
    1164:	02078463          	beqz	a5,118c <sqrt_newton+0x3c>
    1168:	00500793          	li	a5,5
    116c:	00002737          	lui	a4,0x2
    1170:	bd472687          	flw	fa3,-1068(a4) # 1bd4 <circ_buf_close+0x31c>
    1174:	18a7f753          	fdiv.s	fa4,fa5,fa0
    1178:	00a77553          	fadd.s	fa0,fa4,fa0
    117c:	10d57553          	fmul.s	fa0,fa0,fa3
    1180:	fff78793          	addi	a5,a5,-1
    1184:	fe0798e3          	bnez	a5,1174 <sqrt_newton+0x24>
    1188:	00008067          	ret
    118c:	f0000553          	fmv.w.x	fa0,zero
    1190:	00008067          	ret

00001194 <PA>:
    1194:	000027b7          	lui	a5,0x2
    1198:	e1478793          	addi	a5,a5,-492 # 1e14 <E1>
    119c:	0047a787          	flw	fa5,4(a5)
    11a0:	0087a607          	flw	fa2,8(a5)
    11a4:	00c7a587          	flw	fa1,12(a5)
    11a8:	0107a687          	flw	fa3,16(a5)
    11ac:	000027b7          	lui	a5,0x2
    11b0:	e307a007          	flw	ft0,-464(a5) # 1e30 <T>
    11b4:	00000793          	li	a5,0
    11b8:	00002737          	lui	a4,0x2
    11bc:	bc072507          	flw	fa0,-1088(a4) # 1bc0 <circ_buf_close+0x308>
    11c0:	00500713          	li	a4,5
    11c4:	10a6f753          	fmul.s	fa4,fa3,fa0
    11c8:	00e5f753          	fadd.s	fa4,fa1,fa4
    11cc:	00f677d3          	fadd.s	fa5,fa2,fa5
    11d0:	00e7f7d3          	fadd.s	fa5,fa5,fa4
    11d4:	1007f7d3          	fmul.s	fa5,fa5,ft0
    11d8:	10a5f753          	fmul.s	fa4,fa1,fa0
    11dc:	00e67653          	fadd.s	fa2,fa2,fa4
    11e0:	10d07653          	fmul.s	fa2,ft0,fa3
    11e4:	10a67753          	fmul.s	fa4,fa2,fa0
    11e8:	00e7f753          	fadd.s	fa4,fa5,fa4
    11ec:	00b77753          	fadd.s	fa4,fa4,fa1
    11f0:	00d77753          	fadd.s	fa4,fa4,fa3
    11f4:	100775d3          	fmul.s	fa1,fa4,ft0
    11f8:	10a7f753          	fmul.s	fa4,fa5,fa0
    11fc:	00e67753          	fadd.s	fa4,fa2,fa4
    1200:	00e5f753          	fadd.s	fa4,fa1,fa4
    1204:	00d776d3          	fadd.s	fa3,fa4,fa3
    1208:	1006f6d3          	fmul.s	fa3,fa3,ft0
    120c:	00178793          	addi	a5,a5,1
    1210:	faf75ae3          	bge	a4,a5,11c4 <PA+0x30>
    1214:	000027b7          	lui	a5,0x2
    1218:	e1478793          	addi	a5,a5,-492 # 1e14 <E1>
    121c:	00f7a227          	fsw	fa5,4(a5)
    1220:	00c7a427          	fsw	fa2,8(a5)
    1224:	00b7a627          	fsw	fa1,12(a5)
    1228:	00d7a827          	fsw	fa3,16(a5)
    122c:	000027b7          	lui	a5,0x2
    1230:	00600713          	li	a4,6
    1234:	e0e7a823          	sw	a4,-496(a5) # 1e10 <J>
    1238:	00008067          	ret

0000123c <P0>:
    123c:	000027b7          	lui	a5,0x2
    1240:	e0c7a683          	lw	a3,-500(a5) # 1e0c <K>
    1244:	000027b7          	lui	a5,0x2
    1248:	e107a703          	lw	a4,-496(a5) # 1e10 <J>
    124c:	000027b7          	lui	a5,0x2
    1250:	e1478793          	addi	a5,a5,-492 # 1e14 <E1>
    1254:	00269693          	slli	a3,a3,0x2
    1258:	00d786b3          	add	a3,a5,a3
    125c:	0006a787          	flw	fa5,0(a3)
    1260:	00271713          	slli	a4,a4,0x2
    1264:	00e78733          	add	a4,a5,a4
    1268:	00f72027          	fsw	fa5,0(a4)
    126c:	00002637          	lui	a2,0x2
    1270:	e0862603          	lw	a2,-504(a2) # 1e08 <L>
    1274:	00261613          	slli	a2,a2,0x2
    1278:	00c787b3          	add	a5,a5,a2
    127c:	0007a787          	flw	fa5,0(a5)
    1280:	00f6a027          	fsw	fa5,0(a3)
    1284:	00072787          	flw	fa5,0(a4)
    1288:	00f7a027          	fsw	fa5,0(a5)
    128c:	00008067          	ret

00001290 <P3>:
    1290:	000027b7          	lui	a5,0x2
    1294:	e307a787          	flw	fa5,-464(a5) # 1e30 <T>
    1298:	00b57553          	fadd.s	fa0,fa0,fa1
    129c:	10f57553          	fmul.s	fa0,fa0,fa5
    12a0:	00a5f5d3          	fadd.s	fa1,fa1,fa0
    12a4:	10f5f5d3          	fmul.s	fa1,fa1,fa5
    12a8:	00a5f5d3          	fadd.s	fa1,fa1,fa0
    12ac:	000027b7          	lui	a5,0x2
    12b0:	e287a787          	flw	fa5,-472(a5) # 1e28 <T2>
    12b4:	18f5f5d3          	fdiv.s	fa1,fa1,fa5
    12b8:	00b52027          	fsw	fa1,0(a0)
    12bc:	00008067          	ret

000012c0 <main>:
    12c0:	f7010113          	addi	sp,sp,-144
    12c4:	08112623          	sw	ra,140(sp)
    12c8:	08812423          	sw	s0,136(sp)
    12cc:	08912223          	sw	s1,132(sp)
    12d0:	09212023          	sw	s2,128(sp)
    12d4:	07312e23          	sw	s3,124(sp)
    12d8:	07412c23          	sw	s4,120(sp)
    12dc:	07512a23          	sw	s5,116(sp)
    12e0:	07612823          	sw	s6,112(sp)
    12e4:	07712623          	sw	s7,108(sp)
    12e8:	07812423          	sw	s8,104(sp)
    12ec:	07912223          	sw	s9,100(sp)
    12f0:	07a12023          	sw	s10,96(sp)
    12f4:	04812e27          	fsw	fs0,92(sp)
    12f8:	04912c27          	fsw	fs1,88(sp)
    12fc:	05212a27          	fsw	fs2,84(sp)
    1300:	05312827          	fsw	fs3,80(sp)
    1304:	05412627          	fsw	fs4,76(sp)
    1308:	05512427          	fsw	fs5,72(sp)
    130c:	05612227          	fsw	fs6,68(sp)
    1310:	05712027          	fsw	fs7,64(sp)
    1314:	03812e27          	fsw	fs8,60(sp)
    1318:	03912c27          	fsw	fs9,56(sp)
    131c:	03a12a27          	fsw	fs10,52(sp)
    1320:	03b12827          	fsw	fs11,48(sp)
    1324:	00700593          	li	a1,7
    1328:	00002537          	lui	a0,0x2
    132c:	b3450513          	addi	a0,a0,-1228 # 1b34 <circ_buf_close+0x27c>
    1330:	4ec000ef          	jal	181c <uart_write>
    1334:	000029b7          	lui	s3,0x2
    1338:	000027b7          	lui	a5,0x2
    133c:	be87a787          	flw	fa5,-1048(a5) # 1be8 <circ_buf_close+0x330>
    1340:	00f12427          	fsw	fa5,8(sp)
    1344:	00002ab7          	lui	s5,0x2
    1348:	000027b7          	lui	a5,0x2
    134c:	bec7a787          	flw	fa5,-1044(a5) # 1bec <circ_buf_close+0x334>
    1350:	00f12627          	fsw	fa5,12(sp)
    1354:	00002a37          	lui	s4,0x2
    1358:	00002d37          	lui	s10,0x2
    135c:	00002c37          	lui	s8,0x2
    1360:	bc0c2b87          	flw	fs7,-1088(s8) # 1bc0 <circ_buf_close+0x308>
    1364:	000027b7          	lui	a5,0x2
    1368:	bd47ac07          	flw	fs8,-1068(a5) # 1bd4 <circ_buf_close+0x31c>
    136c:	000027b7          	lui	a5,0x2
    1370:	be47a787          	flw	fa5,-1052(a5) # 1be4 <circ_buf_close+0x32c>
    1374:	00f12227          	fsw	fa5,4(sp)
    1378:	00012c23          	sw	zero,24(sp)
    137c:	01810413          	addi	s0,sp,24
    1380:	00200613          	li	a2,2
    1384:	00000593          	li	a1,0
    1388:	00040513          	mv	a0,s0
    138c:	fe9fe0ef          	jal	374 <output_data>
    1390:	00200613          	li	a2,2
    1394:	00000593          	li	a1,0
    1398:	02810513          	addi	a0,sp,40
    139c:	834ff0ef          	jal	3d0 <input_data>
    13a0:	00000293          	li	t0,0
    13a4:	0002a783          	lw	a5,0(t0)
    13a8:	02f12423          	sw	a5,40(sp)
    13ac:	00100793          	li	a5,1
    13b0:	00f12c23          	sw	a5,24(sp)
    13b4:	00200613          	li	a2,2
    13b8:	00000593          	li	a1,0
    13bc:	00040513          	mv	a0,s0
    13c0:	fb5fe0ef          	jal	374 <output_data>
    13c4:	00200613          	li	a2,2
    13c8:	00000593          	li	a1,0
    13cc:	02010513          	addi	a0,sp,32
    13d0:	800ff0ef          	jal	3d0 <input_data>
    13d4:	00000293          	li	t0,0
    13d8:	0002a783          	lw	a5,0(t0)
    13dc:	02f12023          	sw	a5,32(sp)
    13e0:	00812787          	flw	fa5,8(sp)
    13e4:	e2f9a827          	fsw	fa5,-464(s3) # 1e30 <T>
    13e8:	00c12787          	flw	fa5,12(sp)
    13ec:	e2faa627          	fsw	fa5,-468(s5) # 1e2c <T1>
    13f0:	000027b7          	lui	a5,0x2
    13f4:	bf07a787          	flw	fa5,-1040(a5) # 1bf0 <circ_buf_close+0x338>
    13f8:	e2fa2427          	fsw	fa5,-472(s4) # 1e28 <T2>
    13fc:	00a00b93          	li	s7,10
    1400:	00002b37          	lui	s6,0x2
    1404:	bccb2d87          	flw	fs11,-1076(s6) # 1bcc <circ_buf_close+0x314>
    1408:	bc0c2987          	flw	fs3,-1088(s8)
    140c:	00002937          	lui	s2,0x2
    1410:	e1490913          	addi	s2,s2,-492 # 1e14 <E1>
    1414:	00002cb7          	lui	s9,0x2
    1418:	bf0d2d07          	flw	fs10,-1040(s10) # 1bf0 <circ_buf_close+0x338>
    141c:	000027b7          	lui	a5,0x2
    1420:	bd87ac87          	flw	fs9,-1064(a5) # 1bd8 <circ_buf_close+0x320>
    1424:	e309a507          	flw	fa0,-464(s3)
    1428:	000037b7          	lui	a5,0x3
    142c:	edf78793          	addi	a5,a5,-289 # 2edf <uart_read_buff+0x10ab>
    1430:	217b8653          	fmv.s	fa2,fs7
    1434:	217b85d3          	fmv.s	fa1,fs7
    1438:	217b87d3          	fmv.s	fa5,fs7
    143c:	21bd8753          	fmv.s	fa4,fs11
    1440:	113676d3          	fmul.s	fa3,fa2,fs3
    1444:	00d5f6d3          	fadd.s	fa3,fa1,fa3
    1448:	00e7f753          	fadd.s	fa4,fa5,fa4
    144c:	00d77753          	fadd.s	fa4,fa4,fa3
    1450:	10a77753          	fmul.s	fa4,fa4,fa0
    1454:	1135f6d3          	fmul.s	fa3,fa1,fs3
    1458:	00d7f7d3          	fadd.s	fa5,fa5,fa3
    145c:	00f777d3          	fadd.s	fa5,fa4,fa5
    1460:	00c7f7d3          	fadd.s	fa5,fa5,fa2
    1464:	10a7f7d3          	fmul.s	fa5,fa5,fa0
    1468:	1137f6d3          	fmul.s	fa3,fa5,fs3
    146c:	00d776d3          	fadd.s	fa3,fa4,fa3
    1470:	00b6f6d3          	fadd.s	fa3,fa3,fa1
    1474:	00c6f6d3          	fadd.s	fa3,fa3,fa2
    1478:	10a6f5d3          	fmul.s	fa1,fa3,fa0
    147c:	113776d3          	fmul.s	fa3,fa4,fs3
    1480:	00d7f6d3          	fadd.s	fa3,fa5,fa3
    1484:	00d5f6d3          	fadd.s	fa3,fa1,fa3
    1488:	00c6f653          	fadd.s	fa2,fa3,fa2
    148c:	10a67653          	fmul.s	fa2,fa2,fa0
    1490:	fff78793          	addi	a5,a5,-1
    1494:	fa0796e3          	bnez	a5,1440 <main+0x180>
    1498:	00e92227          	fsw	fa4,4(s2)
    149c:	00f92427          	fsw	fa5,8(s2)
    14a0:	00b92627          	fsw	fa1,12(s2)
    14a4:	00c92827          	fsw	fa2,16(s2)
    14a8:	00003437          	lui	s0,0x3
    14ac:	6af40413          	addi	s0,s0,1711 # 36af <uart_read_buff+0x187b>
    14b0:	00090513          	mv	a0,s2
    14b4:	ce1ff0ef          	jal	1194 <PA>
    14b8:	fff40413          	addi	s0,s0,-1
    14bc:	fe041ae3          	bnez	s0,14b0 <main+0x1f0>
    14c0:	000547b7          	lui	a5,0x54
    14c4:	3a778793          	addi	a5,a5,935 # 543a7 <_stack_start+0x4c3a7>
    14c8:	fff78793          	addi	a5,a5,-1
    14cc:	fe079ee3          	bnez	a5,14c8 <main+0x208>
    14d0:	000337b7          	lui	a5,0x33
    14d4:	44f78793          	addi	a5,a5,1103 # 3344f <_stack_start+0x2b44f>
    14d8:	fff78793          	addi	a5,a5,-1
    14dc:	fe079ee3          	bnez	a5,14d8 <main+0x218>
    14e0:	000027b7          	lui	a5,0x2
    14e4:	00100713          	li	a4,1
    14e8:	e0e7a823          	sw	a4,-496(a5) # 1e10 <J>
    14ec:	000027b7          	lui	a5,0x2
    14f0:	00200713          	li	a4,2
    14f4:	e0e7a623          	sw	a4,-500(a5) # 1e0c <K>
    14f8:	000027b7          	lui	a5,0x2
    14fc:	00300713          	li	a4,3
    1500:	e0e7a423          	sw	a4,-504(a5) # 1e08 <L>
    1504:	bf4ca787          	flw	fa5,-1036(s9) # 1bf4 <circ_buf_close+0x33c>
    1508:	00f92427          	fsw	fa5,8(s2)
    150c:	00f92227          	fsw	fa5,4(s2)
    1510:	000084b7          	lui	s1,0x8
    1514:	cff48493          	addi	s1,s1,-769 # 7cff <uart_read_buff+0x5ecb>
    1518:	218c0453          	fmv.s	fs0,fs8
    151c:	218c04d3          	fmv.s	fs1,fs8
    1520:	bc0c2907          	flw	fs2,-1088(s8)
    1524:	bccb2b07          	flw	fs6,-1076(s6)
    1528:	20948553          	fmv.s	fa0,fs1
    152c:	9c5ff0ef          	jal	ef0 <sine_from_rads_interp>
    1530:	e28a2a07          	flw	fs4,-472(s4)
    1534:	11457ad3          	fmul.s	fs5,fa0,fs4
    1538:	20948553          	fmv.s	fa0,fs1
    153c:	d69fe0ef          	jal	2a4 <cosine_from_rads_interp>
    1540:	d00577d3          	fcvt.s.w	fa5,a0
    1544:	1157fad3          	fmul.s	fs5,fa5,fs5
    1548:	0084f553          	fadd.s	fa0,fs1,fs0
    154c:	d59fe0ef          	jal	2a4 <cosine_from_rads_interp>
    1550:	00050413          	mv	s0,a0
    1554:	11247553          	fmul.s	fa0,fs0,fs2
    1558:	00a4f553          	fadd.s	fa0,fs1,fa0
    155c:	112b77d3          	fmul.s	fa5,fs6,fs2
    1560:	00f57553          	fadd.s	fa0,fa0,fa5
    1564:	d41fe0ef          	jal	2a4 <cosine_from_rads_interp>
    1568:	00a40433          	add	s0,s0,a0
    156c:	d0047553          	fcvt.s.w	fa0,s0
    1570:	18aaf553          	fdiv.s	fa0,fs5,fa0
    1574:	a4dff0ef          	jal	fc0 <atan_approx>
    1578:	e309aa87          	flw	fs5,-464(s3)
    157c:	115574d3          	fmul.s	fs1,fa0,fs5
    1580:	20840553          	fmv.s	fa0,fs0
    1584:	96dff0ef          	jal	ef0 <sine_from_rads_interp>
    1588:	10aa7a53          	fmul.s	fs4,fs4,fa0
    158c:	20840553          	fmv.s	fa0,fs0
    1590:	d15fe0ef          	jal	2a4 <cosine_from_rads_interp>
    1594:	d00577d3          	fcvt.s.w	fa5,a0
    1598:	1147fa53          	fmul.s	fs4,fa5,fs4
    159c:	0084f553          	fadd.s	fa0,fs1,fs0
    15a0:	d05fe0ef          	jal	2a4 <cosine_from_rads_interp>
    15a4:	00050413          	mv	s0,a0
    15a8:	11247553          	fmul.s	fa0,fs0,fs2
    15ac:	00a4f553          	fadd.s	fa0,fs1,fa0
    15b0:	112b77d3          	fmul.s	fa5,fs6,fs2
    15b4:	00f57553          	fadd.s	fa0,fa0,fa5
    15b8:	cedfe0ef          	jal	2a4 <cosine_from_rads_interp>
    15bc:	00a40433          	add	s0,s0,a0
    15c0:	d0047553          	fcvt.s.w	fa0,s0
    15c4:	18aa7553          	fdiv.s	fa0,fs4,fa0
    15c8:	9f9ff0ef          	jal	fc0 <atan_approx>
    15cc:	10aaf453          	fmul.s	fs0,fs5,fa0
    15d0:	fff48493          	addi	s1,s1,-1
    15d4:	f4049ae3          	bnez	s1,1528 <main+0x268>
    15d8:	000db437          	lui	s0,0xdb
    15dc:	7b840413          	addi	s0,s0,1976 # db7b8 <_stack_start+0xd37b8>
    15e0:	02c10493          	addi	s1,sp,44
    15e4:	bccb2407          	flw	fs0,-1076(s6)
    15e8:	00048513          	mv	a0,s1
    15ec:	208405d3          	fmv.s	fa1,fs0
    15f0:	20840553          	fmv.s	fa0,fs0
    15f4:	c9dff0ef          	jal	1290 <P3>
    15f8:	fff40413          	addi	s0,s0,-1
    15fc:	fe0416e3          	bnez	s0,15e8 <main+0x328>
    1600:	000027b7          	lui	a5,0x2
    1604:	00100713          	li	a4,1
    1608:	e0e7a823          	sw	a4,-496(a5) # 1e10 <J>
    160c:	000027b7          	lui	a5,0x2
    1610:	00200713          	li	a4,2
    1614:	e0e7a623          	sw	a4,-500(a5) # 1e0c <K>
    1618:	000027b7          	lui	a5,0x2
    161c:	00300713          	li	a4,3
    1620:	e0e7a423          	sw	a4,-504(a5) # 1e08 <L>
    1624:	bccb2787          	flw	fa5,-1076(s6)
    1628:	00f92227          	fsw	fa5,4(s2)
    162c:	01a92427          	fsw	fs10,8(s2)
    1630:	01992627          	fsw	fs9,12(s2)
    1634:	00096437          	lui	s0,0x96
    1638:	63f40413          	addi	s0,s0,1599 # 9663f <_stack_start+0x8e63f>
    163c:	c01ff0ef          	jal	123c <P0>
    1640:	fff40413          	addi	s0,s0,-1
    1644:	fe041ce3          	bnez	s0,163c <main+0x37c>
    1648:	000027b7          	lui	a5,0x2
    164c:	00200713          	li	a4,2
    1650:	e0e7a823          	sw	a4,-496(a5) # 1e10 <J>
    1654:	000027b7          	lui	a5,0x2
    1658:	00300713          	li	a4,3
    165c:	e0e7a623          	sw	a4,-500(a5) # 1e0c <K>
    1660:	00017437          	lui	s0,0x17
    1664:	b4740413          	addi	s0,s0,-1209 # 16b47 <_stack_start+0xeb47>
    1668:	00412507          	flw	fa0,4(sp)
    166c:	9b5ff0ef          	jal	1020 <log_approx>
    1670:	e2caa787          	flw	fa5,-468(s5)
    1674:	18f57553          	fdiv.s	fa0,fa0,fa5
    1678:	aa5ff0ef          	jal	111c <exp_approx>
    167c:	ad5ff0ef          	jal	1150 <sqrt_newton>
    1680:	fff40413          	addi	s0,s0,-1
    1684:	fe0414e3          	bnez	s0,166c <main+0x3ac>
    1688:	fffb8b93          	addi	s7,s7,-1
    168c:	d80b9ce3          	bnez	s7,1424 <main+0x164>
    1690:	00012c23          	sw	zero,24(sp)
    1694:	01810413          	addi	s0,sp,24
    1698:	00200613          	li	a2,2
    169c:	00000593          	li	a1,0
    16a0:	00040513          	mv	a0,s0
    16a4:	cd1fe0ef          	jal	374 <output_data>
    16a8:	00200613          	li	a2,2
    16ac:	00000593          	li	a1,0
    16b0:	02410513          	addi	a0,sp,36
    16b4:	d1dfe0ef          	jal	3d0 <input_data>
    16b8:	00000293          	li	t0,0
    16bc:	0002a783          	lw	a5,0(t0)
    16c0:	02f12223          	sw	a5,36(sp)
    16c4:	00100793          	li	a5,1
    16c8:	00f12c23          	sw	a5,24(sp)
    16cc:	00200613          	li	a2,2
    16d0:	00000593          	li	a1,0
    16d4:	00040513          	mv	a0,s0
    16d8:	c9dfe0ef          	jal	374 <output_data>
    16dc:	00200613          	li	a2,2
    16e0:	00000593          	li	a1,0
    16e4:	01c10513          	addi	a0,sp,28
    16e8:	ce9fe0ef          	jal	3d0 <input_data>
    16ec:	00000293          	li	t0,0
    16f0:	0002a783          	lw	a5,0(t0)
    16f4:	00f12e23          	sw	a5,28(sp)
    16f8:	00002537          	lui	a0,0x2
    16fc:	b3850513          	addi	a0,a0,-1224 # 1b38 <circ_buf_close+0x280>
    1700:	ef9fe0ef          	jal	5f8 <ee_printf>
    1704:	02412783          	lw	a5,36(sp)
    1708:	02812703          	lw	a4,40(sp)
    170c:	40e787b3          	sub	a5,a5,a4
    1710:	08f05a63          	blez	a5,17a4 <main+0x4e4>
    1714:	01c12703          	lw	a4,28(sp)
    1718:	02012683          	lw	a3,32(sp)
    171c:	40d70733          	sub	a4,a4,a3
    1720:	d0077453          	fcvt.s.w	fs0,a4
    1724:	00002737          	lui	a4,0x2
    1728:	bf872787          	flw	fa5,-1032(a4) # 1bf8 <circ_buf_close+0x340>
    172c:	10f47453          	fmul.s	fs0,fs0,fa5
    1730:	d007f7d3          	fcvt.s.w	fa5,a5
    1734:	000027b7          	lui	a5,0x2
    1738:	bfc7a707          	flw	fa4,-1028(a5) # 1bfc <circ_buf_close+0x344>
    173c:	18e7f7d3          	fdiv.s	fa5,fa5,fa4
    1740:	00f47453          	fadd.s	fs0,fs0,fa5
    1744:	00a00613          	li	a2,10
    1748:	3e800593          	li	a1,1000
    174c:	00002537          	lui	a0,0x2
    1750:	b7050513          	addi	a0,a0,-1168 # 1b70 <circ_buf_close+0x2b8>
    1754:	ea5fe0ef          	jal	5f8 <ee_printf>
    1758:	00002537          	lui	a0,0x2
    175c:	b9050513          	addi	a0,a0,-1136 # 1b90 <circ_buf_close+0x2d8>
    1760:	e99fe0ef          	jal	5f8 <ee_printf>
    1764:	20840553          	fmv.s	fa0,fs0
    1768:	d99fe0ef          	jal	500 <print_float>
    176c:	00002437          	lui	s0,0x2
    1770:	b3840513          	addi	a0,s0,-1224 # 1b38 <circ_buf_close+0x280>
    1774:	e85fe0ef          	jal	5f8 <ee_printf>
    1778:	000027b7          	lui	a5,0x2
    177c:	c007a787          	flw	fa5,-1024(a5) # 1c00 <circ_buf_close+0x348>
    1780:	1887f453          	fdiv.s	fs0,fa5,fs0
    1784:	00002537          	lui	a0,0x2
    1788:	ba450513          	addi	a0,a0,-1116 # 1ba4 <circ_buf_close+0x2ec>
    178c:	e6dfe0ef          	jal	5f8 <ee_printf>
    1790:	20840553          	fmv.s	fa0,fs0
    1794:	d6dfe0ef          	jal	500 <print_float>
    1798:	b3840513          	addi	a0,s0,-1224
    179c:	e5dfe0ef          	jal	5f8 <ee_printf>
    17a0:	bd9ff06f          	j	1378 <main+0xb8>
    17a4:	00002537          	lui	a0,0x2
    17a8:	b4050513          	addi	a0,a0,-1216 # 1b40 <circ_buf_close+0x288>
    17ac:	e4dfe0ef          	jal	5f8 <ee_printf>
    17b0:	00100513          	li	a0,1
    17b4:	08c12083          	lw	ra,140(sp)
    17b8:	08812403          	lw	s0,136(sp)
    17bc:	08412483          	lw	s1,132(sp)
    17c0:	08012903          	lw	s2,128(sp)
    17c4:	07c12983          	lw	s3,124(sp)
    17c8:	07812a03          	lw	s4,120(sp)
    17cc:	07412a83          	lw	s5,116(sp)
    17d0:	07012b03          	lw	s6,112(sp)
    17d4:	06c12b83          	lw	s7,108(sp)
    17d8:	06812c03          	lw	s8,104(sp)
    17dc:	06412c83          	lw	s9,100(sp)
    17e0:	06012d03          	lw	s10,96(sp)
    17e4:	05c12407          	flw	fs0,92(sp)
    17e8:	05812487          	flw	fs1,88(sp)
    17ec:	05412907          	flw	fs2,84(sp)
    17f0:	05012987          	flw	fs3,80(sp)
    17f4:	04c12a07          	flw	fs4,76(sp)
    17f8:	04812a87          	flw	fs5,72(sp)
    17fc:	04412b07          	flw	fs6,68(sp)
    1800:	04012b87          	flw	fs7,64(sp)
    1804:	03c12c07          	flw	fs8,60(sp)
    1808:	03812c87          	flw	fs9,56(sp)
    180c:	03412d07          	flw	fs10,52(sp)
    1810:	03012d87          	flw	fs11,48(sp)
    1814:	09010113          	addi	sp,sp,144
    1818:	00008067          	ret

0000181c <uart_write>:
    181c:	04058463          	beqz	a1,1864 <uart_write+0x48>
    1820:	00050693          	mv	a3,a0
    1824:	00b50633          	add	a2,a0,a1
    1828:	80000737          	lui	a4,0x80000
    182c:	00170593          	addi	a1,a4,1 # 80000001 <_stack_start+0x7fff8001>
    1830:	00074783          	lbu	a5,0(a4)
    1834:	0047f793          	andi	a5,a5,4
    1838:	fe078ce3          	beqz	a5,1830 <uart_write+0x14>
    183c:	0006c783          	lbu	a5,0(a3)
    1840:	00f58023          	sb	a5,0(a1)
    1844:	00074783          	lbu	a5,0(a4)
    1848:	0107e793          	ori	a5,a5,16
    184c:	00f70023          	sb	a5,0(a4)
    1850:	00074783          	lbu	a5,0(a4)
    1854:	0ef7f793          	andi	a5,a5,239
    1858:	00f70023          	sb	a5,0(a4)
    185c:	00168693          	addi	a3,a3,1
    1860:	fcc698e3          	bne	a3,a2,1830 <uart_write+0x14>
    1864:	80000737          	lui	a4,0x80000
    1868:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fff8000>
    186c:	0ef7f793          	andi	a5,a5,239
    1870:	00f70023          	sb	a5,0(a4)
    1874:	00074783          	lbu	a5,0(a4)
    1878:	0047f793          	andi	a5,a5,4
    187c:	fe078ce3          	beqz	a5,1874 <uart_write+0x58>
    1880:	00008067          	ret

00001884 <uart_disable>:
    1884:	ff010113          	addi	sp,sp,-16
    1888:	00112623          	sw	ra,12(sp)
    188c:	80000737          	lui	a4,0x80000
    1890:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fff8000>
    1894:	00357513          	andi	a0,a0,3
    1898:	00a7e7b3          	or	a5,a5,a0
    189c:	00f70023          	sb	a5,0(a4)
    18a0:	00002537          	lui	a0,0x2
    18a4:	e3450513          	addi	a0,a0,-460 # 1e34 <uart_read_buff>
    18a8:	010000ef          	jal	18b8 <circ_buf_close>
    18ac:	00c12083          	lw	ra,12(sp)
    18b0:	01010113          	addi	sp,sp,16
    18b4:	00008067          	ret

000018b8 <circ_buf_close>:
    18b8:	fff00793          	li	a5,-1
    18bc:	08f500a3          	sb	a5,129(a0)
    18c0:	00f50023          	sb	a5,0(a0)
    18c4:	08f50123          	sb	a5,130(a0)
    18c8:	00008067          	ret
