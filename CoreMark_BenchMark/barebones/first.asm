
first.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <Reset>:
       0:	00008117          	auipc	sp,0x8
       4:	00010113          	mv	sp,sp
       8:	00004537          	lui	a0,0x4
       c:	00700593          	li	a1,7
      10:	c8050513          	addi	a0,a0,-896 # 3c80 <memcpy+0x7a4>
      14:	374030ef          	jal	3388 <uart_write>
      18:	061000ef          	jal	878 <main>

0000001c <cmp_idx>:
      1c:	00060a63          	beqz	a2,30 <cmp_idx+0x14>
      20:	00251503          	lh	a0,2(a0)
      24:	00259783          	lh	a5,2(a1)
      28:	40f50533          	sub	a0,a0,a5
      2c:	00008067          	ret
      30:	00051783          	lh	a5,0(a0)
      34:	01079693          	slli	a3,a5,0x10
      38:	f007f713          	andi	a4,a5,-256
      3c:	0186d793          	srli	a5,a3,0x18
      40:	00f767b3          	or	a5,a4,a5
      44:	00f51023          	sh	a5,0(a0)
      48:	00059783          	lh	a5,0(a1)
      4c:	00251503          	lh	a0,2(a0)
      50:	01079693          	slli	a3,a5,0x10
      54:	f007f713          	andi	a4,a5,-256
      58:	0186d793          	srli	a5,a3,0x18
      5c:	00f767b3          	or	a5,a4,a5
      60:	00f59023          	sh	a5,0(a1)
      64:	00259783          	lh	a5,2(a1)
      68:	40f50533          	sub	a0,a0,a5
      6c:	00008067          	ret

00000070 <calc_func>:
      70:	00051803          	lh	a6,0(a0)
      74:	40785793          	srai	a5,a6,0x7
      78:	0017f793          	andi	a5,a5,1
      7c:	00078663          	beqz	a5,88 <calc_func+0x18>
      80:	07f87513          	andi	a0,a6,127
      84:	00008067          	ret
      88:	40385713          	srai	a4,a6,0x3
      8c:	00f77713          	andi	a4,a4,15
      90:	fe010113          	addi	sp,sp,-32 # 7fe0 <uart_read_buff+0x37e0>
      94:	00471793          	slli	a5,a4,0x4
      98:	00f70633          	add	a2,a4,a5
      9c:	00812c23          	sw	s0,24(sp)
      a0:	00112e23          	sw	ra,28(sp)
      a4:	00912a23          	sw	s1,20(sp)
      a8:	00787693          	andi	a3,a6,7
      ac:	0385d783          	lhu	a5,56(a1)
      b0:	00058893          	mv	a7,a1
      b4:	00050413          	mv	s0,a0
      b8:	00060713          	mv	a4,a2
      bc:	08068e63          	beqz	a3,158 <calc_func+0xe8>
      c0:	00100613          	li	a2,1
      c4:	08c69263          	bne	a3,a2,148 <calc_func+0xd8>
      c8:	00078613          	mv	a2,a5
      cc:	02888513          	addi	a0,a7,40
      d0:	00070593          	mv	a1,a4
      d4:	01012623          	sw	a6,12(sp)
      d8:	01112423          	sw	a7,8(sp)
      dc:	5a4010ef          	jal	1680 <core_bench_matrix>
      e0:	00812883          	lw	a7,8(sp)
      e4:	01051493          	slli	s1,a0,0x10
      e8:	00c12803          	lw	a6,12(sp)
      ec:	03c8d783          	lhu	a5,60(a7)
      f0:	4104d493          	srai	s1,s1,0x10
      f4:	0a079463          	bnez	a5,19c <calc_func+0x12c>
      f8:	0388d783          	lhu	a5,56(a7)
      fc:	02a89e23          	sh	a0,60(a7)
     100:	00078593          	mv	a1,a5
     104:	01112623          	sw	a7,12(sp)
     108:	01012423          	sw	a6,8(sp)
     10c:	5cd010ef          	jal	1ed8 <crcu16>
     110:	00812803          	lw	a6,8(sp)
     114:	00c12883          	lw	a7,12(sp)
     118:	00050793          	mv	a5,a0
     11c:	f0087813          	andi	a6,a6,-256
     120:	07f4f513          	andi	a0,s1,127
     124:	01056833          	or	a6,a0,a6
     128:	02f89c23          	sh	a5,56(a7)
     12c:	08086813          	ori	a6,a6,128
     130:	01c12083          	lw	ra,28(sp)
     134:	01041023          	sh	a6,0(s0)
     138:	01812403          	lw	s0,24(sp)
     13c:	01412483          	lw	s1,20(sp)
     140:	02010113          	addi	sp,sp,32
     144:	00008067          	ret
     148:	01081513          	slli	a0,a6,0x10
     14c:	01055513          	srli	a0,a0,0x10
     150:	00080493          	mv	s1,a6
     154:	fadff06f          	j	100 <calc_func+0x90>
     158:	02100693          	li	a3,33
     15c:	00c6e463          	bltu	a3,a2,164 <calc_func+0xf4>
     160:	02200713          	li	a4,34
     164:	00289683          	lh	a3,2(a7)
     168:	00089603          	lh	a2,0(a7)
     16c:	0148a583          	lw	a1,20(a7)
     170:	0188a503          	lw	a0,24(a7)
     174:	01012623          	sw	a6,12(sp)
     178:	01112423          	sw	a7,8(sp)
     17c:	345010ef          	jal	1cc0 <core_bench_state>
     180:	00812883          	lw	a7,8(sp)
     184:	01051493          	slli	s1,a0,0x10
     188:	00c12803          	lw	a6,12(sp)
     18c:	03e8d783          	lhu	a5,62(a7)
     190:	4104d493          	srai	s1,s1,0x10
     194:	00079463          	bnez	a5,19c <calc_func+0x12c>
     198:	02a89f23          	sh	a0,62(a7)
     19c:	0388d783          	lhu	a5,56(a7)
     1a0:	f61ff06f          	j	100 <calc_func+0x90>

000001a4 <cmp_complex>:
     1a4:	fe010113          	addi	sp,sp,-32
     1a8:	00912a23          	sw	s1,20(sp)
     1ac:	00058493          	mv	s1,a1
     1b0:	00060593          	mv	a1,a2
     1b4:	00112e23          	sw	ra,28(sp)
     1b8:	00812c23          	sw	s0,24(sp)
     1bc:	00c12623          	sw	a2,12(sp)
     1c0:	eb1ff0ef          	jal	70 <calc_func>
     1c4:	00c12583          	lw	a1,12(sp)
     1c8:	00050413          	mv	s0,a0
     1cc:	00048513          	mv	a0,s1
     1d0:	ea1ff0ef          	jal	70 <calc_func>
     1d4:	01c12083          	lw	ra,28(sp)
     1d8:	40a40533          	sub	a0,s0,a0
     1dc:	01812403          	lw	s0,24(sp)
     1e0:	01412483          	lw	s1,20(sp)
     1e4:	02010113          	addi	sp,sp,32
     1e8:	00008067          	ret

000001ec <core_list_mergesort>:
     1ec:	fd010113          	addi	sp,sp,-48
     1f0:	03212023          	sw	s2,32(sp)
     1f4:	01512a23          	sw	s5,20(sp)
     1f8:	01612823          	sw	s6,16(sp)
     1fc:	01712623          	sw	s7,12(sp)
     200:	01a12023          	sw	s10,0(sp)
     204:	00100a93          	li	s5,1
     208:	02112623          	sw	ra,44(sp)
     20c:	02812423          	sw	s0,40(sp)
     210:	02912223          	sw	s1,36(sp)
     214:	01312e23          	sw	s3,28(sp)
     218:	01412c23          	sw	s4,24(sp)
     21c:	01812423          	sw	s8,8(sp)
     220:	01912223          	sw	s9,4(sp)
     224:	00050913          	mv	s2,a0
     228:	00058b93          	mv	s7,a1
     22c:	00060b13          	mv	s6,a2
     230:	000a8d13          	mv	s10,s5
     234:	0e090863          	beqz	s2,324 <core_list_mergesort+0x138>
     238:	00000c93          	li	s9,0
     23c:	00000493          	li	s1,0
     240:	00000c13          	li	s8,0
     244:	001c8c93          	addi	s9,s9,1
     248:	00090793          	mv	a5,s2
     24c:	00000413          	li	s0,0
     250:	01545863          	bge	s0,s5,260 <core_list_mergesort+0x74>
     254:	0007a783          	lw	a5,0(a5)
     258:	00140413          	addi	s0,s0,1
     25c:	fe079ae3          	bnez	a5,250 <core_list_mergesort+0x64>
     260:	00090993          	mv	s3,s2
     264:	000a8a13          	mv	s4,s5
     268:	00078913          	mv	s2,a5
     26c:	02805463          	blez	s0,294 <core_list_mergesort+0xa8>
     270:	000a0463          	beqz	s4,278 <core_list_mergesort+0x8c>
     274:	02091863          	bnez	s2,2a4 <core_list_mergesort+0xb8>
     278:	00048793          	mv	a5,s1
     27c:	fff40413          	addi	s0,s0,-1
     280:	00098493          	mv	s1,s3
     284:	0009a983          	lw	s3,0(s3)
     288:	04078263          	beqz	a5,2cc <core_list_mergesort+0xe0>
     28c:	0097a023          	sw	s1,0(a5)
     290:	fe8040e3          	bgtz	s0,270 <core_list_mergesort+0x84>
     294:	012037b3          	snez	a5,s2
     298:	07405a63          	blez	s4,30c <core_list_mergesort+0x120>
     29c:	06078a63          	beqz	a5,310 <core_list_mergesort+0x124>
     2a0:	04040463          	beqz	s0,2e8 <core_list_mergesort+0xfc>
     2a4:	00492583          	lw	a1,4(s2)
     2a8:	0049a503          	lw	a0,4(s3)
     2ac:	000b0613          	mv	a2,s6
     2b0:	000b80e7          	jalr	s7
     2b4:	06a05c63          	blez	a0,32c <core_list_mergesort+0x140>
     2b8:	00048793          	mv	a5,s1
     2bc:	fffa0a13          	addi	s4,s4,-1
     2c0:	00090493          	mv	s1,s2
     2c4:	00092903          	lw	s2,0(s2)
     2c8:	fc0792e3          	bnez	a5,28c <core_list_mergesort+0xa0>
     2cc:	00048c13          	mv	s8,s1
     2d0:	f9dff06f          	j	26c <core_list_mergesort+0x80>
     2d4:	00e4a023          	sw	a4,0(s1)
     2d8:	012037b3          	snez	a5,s2
     2dc:	00070493          	mv	s1,a4
     2e0:	020a0463          	beqz	s4,308 <core_list_mergesort+0x11c>
     2e4:	02078263          	beqz	a5,308 <core_list_mergesort+0x11c>
     2e8:	00090713          	mv	a4,s2
     2ec:	fffa0a13          	addi	s4,s4,-1
     2f0:	00092903          	lw	s2,0(s2)
     2f4:	fe0490e3          	bnez	s1,2d4 <core_list_mergesort+0xe8>
     2f8:	00070c13          	mv	s8,a4
     2fc:	012037b3          	snez	a5,s2
     300:	00070493          	mv	s1,a4
     304:	fe0a10e3          	bnez	s4,2e4 <core_list_mergesort+0xf8>
     308:	00070493          	mv	s1,a4
     30c:	f2079ce3          	bnez	a5,244 <core_list_mergesort+0x58>
     310:	0004a023          	sw	zero,0(s1)
     314:	05ac8663          	beq	s9,s10,360 <core_list_mergesort+0x174>
     318:	000c0913          	mv	s2,s8
     31c:	001a9a93          	slli	s5,s5,0x1
     320:	f0091ce3          	bnez	s2,238 <core_list_mergesort+0x4c>
     324:	00002023          	sw	zero,0(zero) # 0 <Reset>
     328:	00100073          	ebreak
     32c:	0009a703          	lw	a4,0(s3)
     330:	fff40413          	addi	s0,s0,-1
     334:	00048c63          	beqz	s1,34c <core_list_mergesort+0x160>
     338:	00048793          	mv	a5,s1
     33c:	00098493          	mv	s1,s3
     340:	0097a023          	sw	s1,0(a5)
     344:	00070993          	mv	s3,a4
     348:	f49ff06f          	j	290 <core_list_mergesort+0xa4>
     34c:	00098c13          	mv	s8,s3
     350:	00098493          	mv	s1,s3
     354:	00070993          	mv	s3,a4
     358:	f48046e3          	bgtz	s0,2a4 <core_list_mergesort+0xb8>
     35c:	f39ff06f          	j	294 <core_list_mergesort+0xa8>
     360:	02c12083          	lw	ra,44(sp)
     364:	02812403          	lw	s0,40(sp)
     368:	02412483          	lw	s1,36(sp)
     36c:	02012903          	lw	s2,32(sp)
     370:	01c12983          	lw	s3,28(sp)
     374:	01812a03          	lw	s4,24(sp)
     378:	01412a83          	lw	s5,20(sp)
     37c:	01012b03          	lw	s6,16(sp)
     380:	00c12b83          	lw	s7,12(sp)
     384:	00412c83          	lw	s9,4(sp)
     388:	00012d03          	lw	s10,0(sp)
     38c:	000c0513          	mv	a0,s8
     390:	00812c03          	lw	s8,8(sp)
     394:	03010113          	addi	sp,sp,48
     398:	00008067          	ret

0000039c <core_bench_list>:
     39c:	00451603          	lh	a2,4(a0)
     3a0:	fd010113          	addi	sp,sp,-48
     3a4:	02812423          	sw	s0,40(sp)
     3a8:	02112623          	sw	ra,44(sp)
     3ac:	02912223          	sw	s1,36(sp)
     3b0:	03212023          	sw	s2,32(sp)
     3b4:	01312e23          	sw	s3,28(sp)
     3b8:	02452403          	lw	s0,36(a0)
     3bc:	28c05e63          	blez	a2,658 <core_bench_list+0x2bc>
     3c0:	2a05c463          	bltz	a1,668 <core_bench_list+0x2cc>
     3c4:	2c040463          	beqz	s0,68c <core_bench_list+0x2f0>
     3c8:	00058693          	mv	a3,a1
     3cc:	00000e13          	li	t3,0
     3d0:	00000f13          	li	t5,0
     3d4:	00000e93          	li	t4,0
     3d8:	00000893          	li	a7,0
     3dc:	00000313          	li	t1,0
     3e0:	00040793          	mv	a5,s0
     3e4:	00c0006f          	j	3f0 <core_bench_list+0x54>
     3e8:	0007a783          	lw	a5,0(a5)
     3ec:	0e078463          	beqz	a5,4d4 <core_bench_list+0x138>
     3f0:	0047a703          	lw	a4,4(a5)
     3f4:	00271803          	lh	a6,2(a4)
     3f8:	fed818e3          	bne	a6,a3,3e8 <core_bench_list+0x4c>
     3fc:	00000693          	li	a3,0
     400:	0080006f          	j	408 <core_bench_list+0x6c>
     404:	00070413          	mv	s0,a4
     408:	00042703          	lw	a4,0(s0)
     40c:	00d42023          	sw	a3,0(s0)
     410:	00040693          	mv	a3,s0
     414:	fe0718e3          	bnez	a4,404 <core_bench_list+0x68>
     418:	0c078263          	beqz	a5,4dc <core_bench_list+0x140>
     41c:	0047a703          	lw	a4,4(a5)
     420:	001e8e93          	addi	t4,t4,1
     424:	00071703          	lh	a4,0(a4)
     428:	00177693          	andi	a3,a4,1
     42c:	00068863          	beqz	a3,43c <core_bench_list+0xa0>
     430:	40975713          	srai	a4,a4,0x9
     434:	00177713          	andi	a4,a4,1
     438:	00e888b3          	add	a7,a7,a4
     43c:	0007a703          	lw	a4,0(a5)
     440:	00070c63          	beqz	a4,458 <core_bench_list+0xbc>
     444:	00072683          	lw	a3,0(a4)
     448:	00d7a023          	sw	a3,0(a5)
     44c:	00042783          	lw	a5,0(s0)
     450:	00f72023          	sw	a5,0(a4)
     454:	00e42023          	sw	a4,0(s0)
     458:	04084063          	bltz	a6,498 <core_bench_list+0xfc>
     45c:	001e0793          	addi	a5,t3,1
     460:	01079e13          	slli	t3,a5,0x10
     464:	00180693          	addi	a3,a6,1
     468:	01069693          	slli	a3,a3,0x10
     46c:	01079793          	slli	a5,a5,0x10
     470:	410e5e13          	srai	t3,t3,0x10
     474:	4106d693          	srai	a3,a3,0x10
     478:	0107d793          	srli	a5,a5,0x10
     47c:	09c60463          	beq	a2,t3,504 <core_bench_list+0x168>
     480:	0ff7f313          	zext.b	t1,a5
     484:	f406dee3          	bgez	a3,3e0 <core_bench_list+0x44>
     488:	00030693          	mv	a3,t1
     48c:	00040793          	mv	a5,s0
     490:	ffff8837          	lui	a6,0xffff8
     494:	0300006f          	j	4c4 <core_bench_list+0x128>
     498:	001e0693          	addi	a3,t3,1
     49c:	01069e13          	slli	t3,a3,0x10
     4a0:	410e5e13          	srai	t3,t3,0x10
     4a4:	01069693          	slli	a3,a3,0x10
     4a8:	0106d693          	srli	a3,a3,0x10
     4ac:	05c60a63          	beq	a2,t3,500 <core_bench_list+0x164>
     4b0:	0ff6f693          	zext.b	a3,a3
     4b4:	00040793          	mv	a5,s0
     4b8:	00c0006f          	j	4c4 <core_bench_list+0x128>
     4bc:	0007a783          	lw	a5,0(a5)
     4c0:	02078c63          	beqz	a5,4f8 <core_bench_list+0x15c>
     4c4:	0047a703          	lw	a4,4(a5)
     4c8:	00074303          	lbu	t1,0(a4)
     4cc:	fed318e3          	bne	t1,a3,4bc <core_bench_list+0x120>
     4d0:	f2dff06f          	j	3fc <core_bench_list+0x60>
     4d4:	00068813          	mv	a6,a3
     4d8:	f25ff06f          	j	3fc <core_bench_list+0x60>
     4dc:	00042783          	lw	a5,0(s0)
     4e0:	001f0f13          	addi	t5,t5,1
     4e4:	0047a783          	lw	a5,4(a5)
     4e8:	00178783          	lb	a5,1(a5)
     4ec:	0017f793          	andi	a5,a5,1
     4f0:	00f888b3          	add	a7,a7,a5
     4f4:	f65ff06f          	j	458 <core_bench_list+0xbc>
     4f8:	00068313          	mv	t1,a3
     4fc:	f01ff06f          	j	3fc <core_bench_list+0x60>
     500:	00080693          	mv	a3,a6
     504:	002e9793          	slli	a5,t4,0x2
     508:	41e787b3          	sub	a5,a5,t5
     50c:	00f888b3          	add	a7,a7,a5
     510:	01089493          	slli	s1,a7,0x10
     514:	0104d493          	srli	s1,s1,0x10
     518:	02b05463          	blez	a1,540 <core_bench_list+0x1a4>
     51c:	00050613          	mv	a2,a0
     520:	1a400593          	li	a1,420
     524:	00040513          	mv	a0,s0
     528:	00612623          	sw	t1,12(sp)
     52c:	00d12423          	sw	a3,8(sp)
     530:	cbdff0ef          	jal	1ec <core_list_mergesort>
     534:	00c12303          	lw	t1,12(sp)
     538:	00812683          	lw	a3,8(sp)
     53c:	00050413          	mv	s0,a0
     540:	00042783          	lw	a5,0(s0)
     544:	00040913          	mv	s2,s0
     548:	0007a983          	lw	s3,0(a5)
     54c:	0047a703          	lw	a4,4(a5)
     550:	0049a583          	lw	a1,4(s3)
     554:	0009a603          	lw	a2,0(s3)
     558:	00b7a223          	sw	a1,4(a5)
     55c:	00e9a223          	sw	a4,4(s3)
     560:	00c7a023          	sw	a2,0(a5)
     564:	0009a023          	sw	zero,0(s3)
     568:	0006d863          	bgez	a3,578 <core_bench_list+0x1dc>
     56c:	0b40006f          	j	620 <core_bench_list+0x284>
     570:	00092903          	lw	s2,0(s2)
     574:	0a090e63          	beqz	s2,630 <core_bench_list+0x294>
     578:	00492783          	lw	a5,4(s2)
     57c:	00279783          	lh	a5,2(a5)
     580:	fed798e3          	bne	a5,a3,570 <core_bench_list+0x1d4>
     584:	00442783          	lw	a5,4(s0)
     588:	00048593          	mv	a1,s1
     58c:	00079503          	lh	a0,0(a5)
     590:	791010ef          	jal	2520 <crc16>
     594:	00092903          	lw	s2,0(s2)
     598:	00050493          	mv	s1,a0
     59c:	fe0914e3          	bnez	s2,584 <core_bench_list+0x1e8>
     5a0:	00042903          	lw	s2,0(s0)
     5a4:	0049a703          	lw	a4,4(s3)
     5a8:	00492683          	lw	a3,4(s2)
     5ac:	00092783          	lw	a5,0(s2)
     5b0:	00d9a223          	sw	a3,4(s3)
     5b4:	00e92223          	sw	a4,4(s2)
     5b8:	00f9a023          	sw	a5,0(s3)
     5bc:	00040513          	mv	a0,s0
     5c0:	01392023          	sw	s3,0(s2)
     5c4:	01c00593          	li	a1,28
     5c8:	00000613          	li	a2,0
     5cc:	c21ff0ef          	jal	1ec <core_list_mergesort>
     5d0:	00052403          	lw	s0,0(a0)
     5d4:	00050913          	mv	s2,a0
     5d8:	02040063          	beqz	s0,5f8 <core_bench_list+0x25c>
     5dc:	00492783          	lw	a5,4(s2)
     5e0:	00048593          	mv	a1,s1
     5e4:	00079503          	lh	a0,0(a5)
     5e8:	739010ef          	jal	2520 <crc16>
     5ec:	00042403          	lw	s0,0(s0)
     5f0:	00050493          	mv	s1,a0
     5f4:	fe0414e3          	bnez	s0,5dc <core_bench_list+0x240>
     5f8:	02c12083          	lw	ra,44(sp)
     5fc:	02812403          	lw	s0,40(sp)
     600:	02012903          	lw	s2,32(sp)
     604:	01c12983          	lw	s3,28(sp)
     608:	00048513          	mv	a0,s1
     60c:	02412483          	lw	s1,36(sp)
     610:	03010113          	addi	sp,sp,48
     614:	00008067          	ret
     618:	00092903          	lw	s2,0(s2)
     61c:	00090a63          	beqz	s2,630 <core_bench_list+0x294>
     620:	00492783          	lw	a5,4(s2)
     624:	0007c783          	lbu	a5,0(a5)
     628:	fef318e3          	bne	t1,a5,618 <core_bench_list+0x27c>
     62c:	f59ff06f          	j	584 <core_bench_list+0x1e8>
     630:	00042903          	lw	s2,0(s0)
     634:	f6090ae3          	beqz	s2,5a8 <core_bench_list+0x20c>
     638:	00442783          	lw	a5,4(s0)
     63c:	00048593          	mv	a1,s1
     640:	00079503          	lh	a0,0(a5)
     644:	6dd010ef          	jal	2520 <crc16>
     648:	00092903          	lw	s2,0(s2)
     64c:	00050493          	mv	s1,a0
     650:	f2091ae3          	bnez	s2,584 <core_bench_list+0x1e8>
     654:	f4dff06f          	j	5a0 <core_bench_list+0x204>
     658:	00058693          	mv	a3,a1
     65c:	00000493          	li	s1,0
     660:	00000313          	li	t1,0
     664:	eb5ff06f          	j	518 <core_bench_list+0x17c>
     668:	02040263          	beqz	s0,68c <core_bench_list+0x2f0>
     66c:	00058813          	mv	a6,a1
     670:	00040793          	mv	a5,s0
     674:	00000893          	li	a7,0
     678:	00000693          	li	a3,0
     67c:	00000f13          	li	t5,0
     680:	00000e13          	li	t3,0
     684:	00000e93          	li	t4,0
     688:	e3dff06f          	j	4c4 <core_bench_list+0x128>
     68c:	00002783          	lw	a5,0(zero) # 0 <Reset>
     690:	00100073          	ebreak

00000694 <core_list_init>:
     694:	ccccd7b7          	lui	a5,0xccccd
     698:	ccd78793          	addi	a5,a5,-819 # cccccccd <_stack_start+0xcccc4ccd>
     69c:	02f538b3          	mulhu	a7,a0,a5
     6a0:	00058513          	mv	a0,a1
     6a4:	0005a023          	sw	zero,0(a1)
     6a8:	ffff87b7          	lui	a5,0xffff8
     6ac:	08078793          	addi	a5,a5,128 # ffff8080 <_stack_start+0xffff0080>
     6b0:	01058693          	addi	a3,a1,16
     6b4:	ffff8737          	lui	a4,0xffff8
     6b8:	00858593          	addi	a1,a1,8
     6bc:	0048d893          	srli	a7,a7,0x4
     6c0:	ffe88893          	addi	a7,a7,-2
     6c4:	00389e13          	slli	t3,a7,0x3
     6c8:	01c50e33          	add	t3,a0,t3
     6cc:	01c52223          	sw	t3,4(a0)
     6d0:	00fe1023          	sh	a5,0(t3)
     6d4:	00289f13          	slli	t5,a7,0x2
     6d8:	000e1123          	sh	zero,2(t3)
     6dc:	01ee0f33          	add	t5,t3,t5
     6e0:	004e0793          	addi	a5,t3,4
     6e4:	11c6f063          	bgeu	a3,t3,7e4 <core_list_init+0x150>
     6e8:	008e0813          	addi	a6,t3,8
     6ec:	0fe87c63          	bgeu	a6,t5,7e4 <core_list_init+0x150>
     6f0:	00f52623          	sw	a5,12(a0)
     6f4:	00052423          	sw	zero,8(a0)
     6f8:	00b52023          	sw	a1,0(a0)
     6fc:	fff74713          	not	a4,a4
     700:	fff00793          	li	a5,-1
     704:	00ee1323          	sh	a4,6(t3)
     708:	00fe1223          	sh	a5,4(t3)
     70c:	ffff8fb7          	lui	t6,0xffff8
     710:	ffffcf93          	not	t6,t6
     714:	00000713          	li	a4,0
     718:	04088c63          	beqz	a7,770 <core_list_init+0xdc>
     71c:	00c747b3          	xor	a5,a4,a2
     720:	00379793          	slli	a5,a5,0x3
     724:	00777593          	andi	a1,a4,7
     728:	0787f793          	andi	a5,a5,120
     72c:	00b7e7b3          	or	a5,a5,a1
     730:	00879e93          	slli	t4,a5,0x8
     734:	00868313          	addi	t1,a3,8
     738:	00170713          	addi	a4,a4,1 # ffff8001 <_stack_start+0xffff0001>
     73c:	00480593          	addi	a1,a6,4 # ffff8004 <_stack_start+0xffff0004>
     740:	01d787b3          	add	a5,a5,t4
     744:	03c37463          	bgeu	t1,t3,76c <core_list_init+0xd8>
     748:	03e5f263          	bgeu	a1,t5,76c <core_list_init+0xd8>
     74c:	00052e83          	lw	t4,0(a0)
     750:	01d6a023          	sw	t4,0(a3)
     754:	00d52023          	sw	a3,0(a0)
     758:	0106a223          	sw	a6,4(a3)
     75c:	00f81023          	sh	a5,0(a6)
     760:	01f81123          	sh	t6,2(a6)
     764:	00030693          	mv	a3,t1
     768:	00058813          	mv	a6,a1
     76c:	fae898e3          	bne	a7,a4,71c <core_list_init+0x88>
     770:	00052583          	lw	a1,0(a0)
     774:	0005a683          	lw	a3,0(a1)
     778:	06068063          	beqz	a3,7d8 <core_list_init+0x144>
     77c:	ccccd7b7          	lui	a5,0xccccd
     780:	ccd78793          	addi	a5,a5,-819 # cccccccd <_stack_start+0xcccc4ccd>
     784:	02f8b8b3          	mulhu	a7,a7,a5
     788:	00004e37          	lui	t3,0x4
     78c:	fffe0e13          	addi	t3,t3,-1 # 3fff <intpat+0x273>
     790:	20000813          	li	a6,512
     794:	00100713          	li	a4,1
     798:	0028d893          	srli	a7,a7,0x2
     79c:	0080006f          	j	7a4 <core_list_init+0x110>
     7a0:	00030693          	mv	a3,t1
     7a4:	70087793          	andi	a5,a6,1792
     7a8:	00e64333          	xor	t1,a2,a4
     7ac:	0067e7b3          	or	a5,a5,t1
     7b0:	0045a583          	lw	a1,4(a1)
     7b4:	01c7f7b3          	and	a5,a5,t3
     7b8:	01177463          	bgeu	a4,a7,7c0 <core_list_init+0x12c>
     7bc:	00070793          	mv	a5,a4
     7c0:	0006a303          	lw	t1,0(a3)
     7c4:	00f59123          	sh	a5,2(a1)
     7c8:	00170713          	addi	a4,a4,1
     7cc:	10080813          	addi	a6,a6,256
     7d0:	00068593          	mv	a1,a3
     7d4:	fc0316e3          	bnez	t1,7a0 <core_list_init+0x10c>
     7d8:	01c00593          	li	a1,28
     7dc:	00000613          	li	a2,0
     7e0:	a0dff06f          	j	1ec <core_list_mergesort>
     7e4:	00078813          	mv	a6,a5
     7e8:	00058693          	mv	a3,a1
     7ec:	f21ff06f          	j	70c <core_list_init+0x78>

000007f0 <iterate>:
     7f0:	ff010113          	addi	sp,sp,-16
     7f4:	01212023          	sw	s2,0(sp)
     7f8:	01c52903          	lw	s2,28(a0)
     7fc:	00112623          	sw	ra,12(sp)
     800:	02052c23          	sw	zero,56(a0)
     804:	02052e23          	sw	zero,60(a0)
     808:	04090e63          	beqz	s2,864 <iterate+0x74>
     80c:	00812423          	sw	s0,8(sp)
     810:	00912223          	sw	s1,4(sp)
     814:	00050413          	mv	s0,a0
     818:	00000493          	li	s1,0
     81c:	00100593          	li	a1,1
     820:	00040513          	mv	a0,s0
     824:	b79ff0ef          	jal	39c <core_bench_list>
     828:	03845583          	lhu	a1,56(s0)
     82c:	6ac010ef          	jal	1ed8 <crcu16>
     830:	02a41c23          	sh	a0,56(s0)
     834:	fff00593          	li	a1,-1
     838:	00040513          	mv	a0,s0
     83c:	b61ff0ef          	jal	39c <core_bench_list>
     840:	03845583          	lhu	a1,56(s0)
     844:	694010ef          	jal	1ed8 <crcu16>
     848:	02a41c23          	sh	a0,56(s0)
     84c:	00049463          	bnez	s1,854 <iterate+0x64>
     850:	02a41d23          	sh	a0,58(s0)
     854:	00148493          	addi	s1,s1,1
     858:	fc9912e3          	bne	s2,s1,81c <iterate+0x2c>
     85c:	00812403          	lw	s0,8(sp)
     860:	00412483          	lw	s1,4(sp)
     864:	00c12083          	lw	ra,12(sp)
     868:	00012903          	lw	s2,0(sp)
     86c:	00000513          	li	a0,0
     870:	01010113          	addi	sp,sp,16
     874:	00008067          	ret

00000878 <main>:
     878:	f8010113          	addi	sp,sp,-128
     87c:	00810613          	addi	a2,sp,8
     880:	00410593          	addi	a1,sp,4
     884:	04e10513          	addi	a0,sp,78
     888:	06112e23          	sw	ra,124(sp)
     88c:	06812c23          	sw	s0,120(sp)
     890:	06912a23          	sw	s1,116(sp)
     894:	07212823          	sw	s2,112(sp)
     898:	07512223          	sw	s5,100(sp)
     89c:	07612023          	sw	s6,96(sp)
     8a0:	05812c23          	sw	s8,88(sp)
     8a4:	00012223          	sw	zero,4(sp)
     8a8:	751000ef          	jal	17f8 <portable_init>
     8ac:	00100513          	li	a0,1
     8b0:	5c4010ef          	jal	1e74 <get_seed_32>
     8b4:	00a11623          	sh	a0,12(sp)
     8b8:	00200513          	li	a0,2
     8bc:	5b8010ef          	jal	1e74 <get_seed_32>
     8c0:	00a11723          	sh	a0,14(sp)
     8c4:	00300513          	li	a0,3
     8c8:	5ac010ef          	jal	1e74 <get_seed_32>
     8cc:	00a11823          	sh	a0,16(sp)
     8d0:	00400513          	li	a0,4
     8d4:	5a0010ef          	jal	1e74 <get_seed_32>
     8d8:	02a12423          	sw	a0,40(sp)
     8dc:	00500513          	li	a0,5
     8e0:	594010ef          	jal	1e74 <get_seed_32>
     8e4:	00051463          	bnez	a0,8ec <main+0x74>
     8e8:	00700513          	li	a0,7
     8ec:	00c12783          	lw	a5,12(sp)
     8f0:	02a12623          	sw	a0,44(sp)
     8f4:	36078663          	beqz	a5,c60 <main+0x3e8>
     8f8:	00100713          	li	a4,1
     8fc:	68e78c63          	beq	a5,a4,f94 <main+0x71c>
     900:	00004837          	lui	a6,0x4
     904:	00257793          	andi	a5,a0,2
     908:	00f037b3          	snez	a5,a5
     90c:	01c80813          	addi	a6,a6,28 # 401c <static_memblk>
     910:	00157713          	andi	a4,a0,1
     914:	00f70733          	add	a4,a4,a5
     918:	04011623          	sh	zero,76(sp)
     91c:	01012a23          	sw	a6,20(sp)
     920:	00457793          	andi	a5,a0,4
     924:	00078863          	beqz	a5,934 <main+0xbc>
     928:	00170713          	addi	a4,a4,1
     92c:	01071713          	slli	a4,a4,0x10
     930:	01075713          	srli	a4,a4,0x10
     934:	7d000593          	li	a1,2000
     938:	02e5d5b3          	divu	a1,a1,a4
     93c:	00c10693          	addi	a3,sp,12
     940:	00000793          	li	a5,0
     944:	00000613          	li	a2,0
     948:	00100313          	li	t1,1
     94c:	00300893          	li	a7,3
     950:	02b12223          	sw	a1,36(sp)
     954:	00f31733          	sll	a4,t1,a5
     958:	00a77733          	and	a4,a4,a0
     95c:	00178793          	addi	a5,a5,1
     960:	14071c63          	bnez	a4,ab8 <main+0x240>
     964:	00468693          	addi	a3,a3,4
     968:	ff1796e3          	bne	a5,a7,954 <main+0xdc>
     96c:	02c12783          	lw	a5,44(sp)
     970:	0017f713          	andi	a4,a5,1
     974:	00070e63          	beqz	a4,990 <main+0x118>
     978:	00c11603          	lh	a2,12(sp)
     97c:	01812583          	lw	a1,24(sp)
     980:	02412503          	lw	a0,36(sp)
     984:	d11ff0ef          	jal	694 <core_list_init>
     988:	02c12783          	lw	a5,44(sp)
     98c:	02a12823          	sw	a0,48(sp)
     990:	0027f713          	andi	a4,a5,2
     994:	0e071e63          	bnez	a4,a90 <main+0x218>
     998:	0047f793          	andi	a5,a5,4
     99c:	00078a63          	beqz	a5,9b0 <main+0x138>
     9a0:	02012603          	lw	a2,32(sp)
     9a4:	00c11583          	lh	a1,12(sp)
     9a8:	02412503          	lw	a0,36(sp)
     9ac:	699000ef          	jal	1844 <core_init_state>
     9b0:	02812783          	lw	a5,40(sp)
     9b4:	04079a63          	bnez	a5,a08 <main+0x190>
     9b8:	00100793          	li	a5,1
     9bc:	02f12423          	sw	a5,40(sp)
     9c0:	02812703          	lw	a4,40(sp)
     9c4:	00271793          	slli	a5,a4,0x2
     9c8:	00e787b3          	add	a5,a5,a4
     9cc:	00179793          	slli	a5,a5,0x1
     9d0:	02f12423          	sw	a5,40(sp)
     9d4:	579000ef          	jal	174c <start_time>
     9d8:	00c10513          	addi	a0,sp,12
     9dc:	e15ff0ef          	jal	7f0 <iterate>
     9e0:	5ad000ef          	jal	178c <stop_time>
     9e4:	5e9000ef          	jal	17cc <get_time>
     9e8:	5fd000ef          	jal	17e4 <time_in_secs>
     9ec:	fc050ae3          	beqz	a0,9c0 <main+0x148>
     9f0:	00a00793          	li	a5,10
     9f4:	02a7d7b3          	divu	a5,a5,a0
     9f8:	02812703          	lw	a4,40(sp)
     9fc:	00178793          	addi	a5,a5,1
     a00:	02f707b3          	mul	a5,a4,a5
     a04:	02f12423          	sw	a5,40(sp)
     a08:	545000ef          	jal	174c <start_time>
     a0c:	00c10513          	addi	a0,sp,12
     a10:	de1ff0ef          	jal	7f0 <iterate>
     a14:	579000ef          	jal	178c <stop_time>
     a18:	5b5000ef          	jal	17cc <get_time>
     a1c:	00050a93          	mv	s5,a0
     a20:	00c11503          	lh	a0,12(sp)
     a24:	00000593          	li	a1,0
     a28:	2f9010ef          	jal	2520 <crc16>
     a2c:	00050593          	mv	a1,a0
     a30:	00e11503          	lh	a0,14(sp)
     a34:	2ed010ef          	jal	2520 <crc16>
     a38:	00050593          	mv	a1,a0
     a3c:	01011503          	lh	a0,16(sp)
     a40:	2e1010ef          	jal	2520 <crc16>
     a44:	00050593          	mv	a1,a0
     a48:	02411503          	lh	a0,36(sp)
     a4c:	2d5010ef          	jal	2520 <crc16>
     a50:	000087b7          	lui	a5,0x8
     a54:	b0578793          	addi	a5,a5,-1275 # 7b05 <uart_read_buff+0x3305>
     a58:	00050b13          	mv	s6,a0
     a5c:	50f50863          	beq	a0,a5,f6c <main+0x6f4>
     a60:	06a7fa63          	bgeu	a5,a0,ad4 <main+0x25c>
     a64:	000097b7          	lui	a5,0x9
     a68:	a0278793          	addi	a5,a5,-1534 # 8a02 <_stack_start+0xa02>
     a6c:	50f50a63          	beq	a0,a5,f80 <main+0x708>
     a70:	0000f7b7          	lui	a5,0xf
     a74:	9f578793          	addi	a5,a5,-1547 # e9f5 <_stack_start+0x69f5>
     a78:	1ef51e63          	bne	a0,a5,c74 <main+0x3fc>
     a7c:	00004537          	lui	a0,0x4
     a80:	89850513          	addi	a0,a0,-1896 # 3898 <memcpy+0x3bc>
     a84:	010020ef          	jal	2a94 <ee_printf>
     a88:	00300913          	li	s2,3
     a8c:	0700006f          	j	afc <main+0x284>
     a90:	00e11783          	lh	a5,14(sp)
     a94:	00c11603          	lh	a2,12(sp)
     a98:	01c12583          	lw	a1,28(sp)
     a9c:	02412503          	lw	a0,36(sp)
     aa0:	01079793          	slli	a5,a5,0x10
     aa4:	00c7e633          	or	a2,a5,a2
     aa8:	03410693          	addi	a3,sp,52
     aac:	51c000ef          	jal	fc8 <core_init_matrix>
     ab0:	02c12783          	lw	a5,44(sp)
     ab4:	ee5ff06f          	j	998 <main+0x120>
     ab8:	02b60733          	mul	a4,a2,a1
     abc:	00160613          	addi	a2,a2,1
     ac0:	01061613          	slli	a2,a2,0x10
     ac4:	01065613          	srli	a2,a2,0x10
     ac8:	00e80733          	add	a4,a6,a4
     acc:	00e6a623          	sw	a4,12(a3)
     ad0:	e95ff06f          	j	964 <main+0xec>
     ad4:	000027b7          	lui	a5,0x2
     ad8:	8f278793          	addi	a5,a5,-1806 # 18f2 <core_init_state+0xae>
     adc:	46f50e63          	beq	a0,a5,f58 <main+0x6e0>
     ae0:	000057b7          	lui	a5,0x5
     ae4:	eaf78793          	addi	a5,a5,-337 # 4eaf <uart_read_buff+0x6af>
     ae8:	18f51663          	bne	a0,a5,c74 <main+0x3fc>
     aec:	00004537          	lui	a0,0x4
     af0:	86450513          	addi	a0,a0,-1948 # 3864 <memcpy+0x388>
     af4:	7a1010ef          	jal	2a94 <ee_printf>
     af8:	00200913          	li	s2,2
     afc:	00004c37          	lui	s8,0x4
     b00:	010c2783          	lw	a5,16(s8) # 4010 <default_num_contexts>
     b04:	4a078863          	beqz	a5,fb4 <main+0x73c>
     b08:	07312623          	sw	s3,108(sp)
     b0c:	07412423          	sw	s4,104(sp)
     b10:	000049b7          	lui	s3,0x4
     b14:	00004a37          	lui	s4,0x4
     b18:	00191913          	slli	s2,s2,0x1
     b1c:	ca0a0a13          	addi	s4,s4,-864 # 3ca0 <list_known_crc>
     b20:	c9498993          	addi	s3,s3,-876 # 3c94 <matrix_known_crc>
     b24:	05712e23          	sw	s7,92(sp)
     b28:	05912a23          	sw	s9,84(sp)
     b2c:	012a0a33          	add	s4,s4,s2
     b30:	012989b3          	add	s3,s3,s2
     b34:	00000c93          	li	s9,0
     b38:	00000b93          	li	s7,0
     b3c:	02c0006f          	j	b68 <main+0x2f0>
     b40:	00241413          	slli	s0,s0,0x2
     b44:	00240433          	add	s0,s0,sp
     b48:	04c45783          	lhu	a5,76(s0)
     b4c:	019784b3          	add	s1,a5,s9
     b50:	001b8b93          	addi	s7,s7,1
     b54:	010c2783          	lw	a5,16(s8)
     b58:	010b9b93          	slli	s7,s7,0x10
     b5c:	010bdb93          	srli	s7,s7,0x10
     b60:	00048c93          	mv	s9,s1
     b64:	0efbf463          	bgeu	s7,a5,c4c <main+0x3d4>
     b68:	004b9413          	slli	s0,s7,0x4
     b6c:	017404b3          	add	s1,s0,s7
     b70:	00249493          	slli	s1,s1,0x2
     b74:	05048793          	addi	a5,s1,80
     b78:	002784b3          	add	s1,a5,sp
     b7c:	fdc4a783          	lw	a5,-36(s1)
     b80:	fe049e23          	sh	zero,-4(s1)
     b84:	0017f713          	andi	a4,a5,1
     b88:	02070863          	beqz	a4,bb8 <main+0x340>
     b8c:	ff64d603          	lhu	a2,-10(s1)
     b90:	000a5683          	lhu	a3,0(s4)
     b94:	02d60263          	beq	a2,a3,bb8 <main+0x340>
     b98:	00004537          	lui	a0,0x4
     b9c:	8f850513          	addi	a0,a0,-1800 # 38f8 <memcpy+0x41c>
     ba0:	000b8593          	mv	a1,s7
     ba4:	6f1010ef          	jal	2a94 <ee_printf>
     ba8:	ffc4d703          	lhu	a4,-4(s1)
     bac:	fdc4a783          	lw	a5,-36(s1)
     bb0:	00170713          	addi	a4,a4,1
     bb4:	fee49e23          	sh	a4,-4(s1)
     bb8:	0027f713          	andi	a4,a5,2
     bbc:	04070063          	beqz	a4,bfc <main+0x384>
     bc0:	017404b3          	add	s1,s0,s7
     bc4:	00249493          	slli	s1,s1,0x2
     bc8:	05048713          	addi	a4,s1,80
     bcc:	002704b3          	add	s1,a4,sp
     bd0:	ff84d603          	lhu	a2,-8(s1)
     bd4:	0009d683          	lhu	a3,0(s3)
     bd8:	02d60263          	beq	a2,a3,bfc <main+0x384>
     bdc:	00004537          	lui	a0,0x4
     be0:	92850513          	addi	a0,a0,-1752 # 3928 <memcpy+0x44c>
     be4:	000b8593          	mv	a1,s7
     be8:	6ad010ef          	jal	2a94 <ee_printf>
     bec:	ffc4d703          	lhu	a4,-4(s1)
     bf0:	fdc4a783          	lw	a5,-36(s1)
     bf4:	00170713          	addi	a4,a4,1
     bf8:	fee49e23          	sh	a4,-4(s1)
     bfc:	0047f793          	andi	a5,a5,4
     c00:	01740433          	add	s0,s0,s7
     c04:	f2078ee3          	beqz	a5,b40 <main+0x2c8>
     c08:	00241413          	slli	s0,s0,0x2
     c0c:	000047b7          	lui	a5,0x4
     c10:	c8878793          	addi	a5,a5,-888 # 3c88 <state_known_crc>
     c14:	05040713          	addi	a4,s0,80
     c18:	00270433          	add	s0,a4,sp
     c1c:	012787b3          	add	a5,a5,s2
     c20:	ffa45603          	lhu	a2,-6(s0)
     c24:	0007d683          	lhu	a3,0(a5)
     c28:	2ad61463          	bne	a2,a3,ed0 <main+0x658>
     c2c:	ffc45783          	lhu	a5,-4(s0)
     c30:	001b8b93          	addi	s7,s7,1
     c34:	010b9b93          	slli	s7,s7,0x10
     c38:	019784b3          	add	s1,a5,s9
     c3c:	010c2783          	lw	a5,16(s8)
     c40:	010bdb93          	srli	s7,s7,0x10
     c44:	00048c93          	mv	s9,s1
     c48:	f2fbe0e3          	bltu	s7,a5,b68 <main+0x2f0>
     c4c:	06c12983          	lw	s3,108(sp)
     c50:	06812a03          	lw	s4,104(sp)
     c54:	05c12b83          	lw	s7,92(sp)
     c58:	05412c83          	lw	s9,84(sp)
     c5c:	0240006f          	j	c80 <main+0x408>
     c60:	01011783          	lh	a5,16(sp)
     c64:	c8079ee3          	bnez	a5,900 <main+0x88>
     c68:	06600793          	li	a5,102
     c6c:	00f11823          	sh	a5,16(sp)
     c70:	c91ff06f          	j	900 <main+0x88>
     c74:	000107b7          	lui	a5,0x10
     c78:	fff78493          	addi	s1,a5,-1 # ffff <_stack_start+0x7fff>
     c7c:	00004c37          	lui	s8,0x4
     c80:	2cd010ef          	jal	274c <check_data_types>
     c84:	02412583          	lw	a1,36(sp)
     c88:	009504b3          	add	s1,a0,s1
     c8c:	00004537          	lui	a0,0x4
     c90:	99050513          	addi	a0,a0,-1648 # 3990 <memcpy+0x4b4>
     c94:	601010ef          	jal	2a94 <ee_printf>
     c98:	00004537          	lui	a0,0x4
     c9c:	000a8593          	mv	a1,s5
     ca0:	9ac50513          	addi	a0,a0,-1620 # 39ac <memcpy+0x4d0>
     ca4:	5f1010ef          	jal	2a94 <ee_printf>
     ca8:	000a8513          	mv	a0,s5
     cac:	339000ef          	jal	17e4 <time_in_secs>
     cb0:	00050593          	mv	a1,a0
     cb4:	00004537          	lui	a0,0x4
     cb8:	9c850513          	addi	a0,a0,-1592 # 39c8 <memcpy+0x4ec>
     cbc:	5d9010ef          	jal	2a94 <ee_printf>
     cc0:	000a8513          	mv	a0,s5
     cc4:	321000ef          	jal	17e4 <time_in_secs>
     cc8:	24051263          	bnez	a0,f0c <main+0x694>
     ccc:	000a8513          	mv	a0,s5
     cd0:	315000ef          	jal	17e4 <time_in_secs>
     cd4:	00900793          	li	a5,9
     cd8:	22a7f063          	bgeu	a5,a0,ef8 <main+0x680>
     cdc:	010c2783          	lw	a5,16(s8) # 4010 <default_num_contexts>
     ce0:	02812583          	lw	a1,40(sp)
     ce4:	00004537          	lui	a0,0x4
     ce8:	a3850513          	addi	a0,a0,-1480 # 3a38 <memcpy+0x55c>
     cec:	02f585b3          	mul	a1,a1,a5
     cf0:	01049493          	slli	s1,s1,0x10
     cf4:	4104d493          	srai	s1,s1,0x10
     cf8:	59d010ef          	jal	2a94 <ee_printf>
     cfc:	000045b7          	lui	a1,0x4
     d00:	00004537          	lui	a0,0x4
     d04:	a5458593          	addi	a1,a1,-1452 # 3a54 <memcpy+0x578>
     d08:	a7050513          	addi	a0,a0,-1424 # 3a70 <memcpy+0x594>
     d0c:	589010ef          	jal	2a94 <ee_printf>
     d10:	000045b7          	lui	a1,0x4
     d14:	00004537          	lui	a0,0x4
     d18:	a8858593          	addi	a1,a1,-1400 # 3a88 <memcpy+0x5ac>
     d1c:	ae850513          	addi	a0,a0,-1304 # 3ae8 <memcpy+0x60c>
     d20:	575010ef          	jal	2a94 <ee_printf>
     d24:	000045b7          	lui	a1,0x4
     d28:	00004537          	lui	a0,0x4
     d2c:	b0058593          	addi	a1,a1,-1280 # 3b00 <memcpy+0x624>
     d30:	b0850513          	addi	a0,a0,-1272 # 3b08 <memcpy+0x62c>
     d34:	561010ef          	jal	2a94 <ee_printf>
     d38:	00004537          	lui	a0,0x4
     d3c:	000b0593          	mv	a1,s6
     d40:	b2050513          	addi	a0,a0,-1248 # 3b20 <memcpy+0x644>
     d44:	551010ef          	jal	2a94 <ee_printf>
     d48:	02c12783          	lw	a5,44(sp)
     d4c:	0017f713          	andi	a4,a5,1
     d50:	04070863          	beqz	a4,da0 <main+0x528>
     d54:	010c2703          	lw	a4,16(s8)
     d58:	04070463          	beqz	a4,da0 <main+0x528>
     d5c:	00004937          	lui	s2,0x4
     d60:	b3c90913          	addi	s2,s2,-1220 # 3b3c <memcpy+0x660>
     d64:	00000413          	li	s0,0
     d68:	00441793          	slli	a5,s0,0x4
     d6c:	008787b3          	add	a5,a5,s0
     d70:	00279793          	slli	a5,a5,0x2
     d74:	002787b3          	add	a5,a5,sp
     d78:	0467d603          	lhu	a2,70(a5)
     d7c:	00040593          	mv	a1,s0
     d80:	00090513          	mv	a0,s2
     d84:	511010ef          	jal	2a94 <ee_printf>
     d88:	00140413          	addi	s0,s0,1
     d8c:	010c2783          	lw	a5,16(s8)
     d90:	01041413          	slli	s0,s0,0x10
     d94:	01045413          	srli	s0,s0,0x10
     d98:	fcf468e3          	bltu	s0,a5,d68 <main+0x4f0>
     d9c:	02c12783          	lw	a5,44(sp)
     da0:	0027f713          	andi	a4,a5,2
     da4:	04070863          	beqz	a4,df4 <main+0x57c>
     da8:	010c2703          	lw	a4,16(s8)
     dac:	20070863          	beqz	a4,fbc <main+0x744>
     db0:	00004937          	lui	s2,0x4
     db4:	b5c90913          	addi	s2,s2,-1188 # 3b5c <memcpy+0x680>
     db8:	00000413          	li	s0,0
     dbc:	00441793          	slli	a5,s0,0x4
     dc0:	008787b3          	add	a5,a5,s0
     dc4:	00279793          	slli	a5,a5,0x2
     dc8:	002787b3          	add	a5,a5,sp
     dcc:	0487d603          	lhu	a2,72(a5)
     dd0:	00040593          	mv	a1,s0
     dd4:	00090513          	mv	a0,s2
     dd8:	4bd010ef          	jal	2a94 <ee_printf>
     ddc:	00140413          	addi	s0,s0,1
     de0:	010c2783          	lw	a5,16(s8)
     de4:	01041413          	slli	s0,s0,0x10
     de8:	01045413          	srli	s0,s0,0x10
     dec:	fcf468e3          	bltu	s0,a5,dbc <main+0x544>
     df0:	02c12783          	lw	a5,44(sp)
     df4:	0047f793          	andi	a5,a5,4
     df8:	04078663          	beqz	a5,e44 <main+0x5cc>
     dfc:	010c2783          	lw	a5,16(s8)
     e00:	08078663          	beqz	a5,e8c <main+0x614>
     e04:	00004937          	lui	s2,0x4
     e08:	b7c90913          	addi	s2,s2,-1156 # 3b7c <memcpy+0x6a0>
     e0c:	00000413          	li	s0,0
     e10:	00441793          	slli	a5,s0,0x4
     e14:	008787b3          	add	a5,a5,s0
     e18:	00279793          	slli	a5,a5,0x2
     e1c:	002787b3          	add	a5,a5,sp
     e20:	04a7d603          	lhu	a2,74(a5)
     e24:	00040593          	mv	a1,s0
     e28:	00090513          	mv	a0,s2
     e2c:	469010ef          	jal	2a94 <ee_printf>
     e30:	00140413          	addi	s0,s0,1
     e34:	010c2783          	lw	a5,16(s8)
     e38:	01041413          	slli	s0,s0,0x10
     e3c:	01045413          	srli	s0,s0,0x10
     e40:	fcf468e3          	bltu	s0,a5,e10 <main+0x598>
     e44:	010c2783          	lw	a5,16(s8)
     e48:	00004937          	lui	s2,0x4
     e4c:	b9c90913          	addi	s2,s2,-1124 # 3b9c <memcpy+0x6c0>
     e50:	00000413          	li	s0,0
     e54:	02078c63          	beqz	a5,e8c <main+0x614>
     e58:	00441793          	slli	a5,s0,0x4
     e5c:	008787b3          	add	a5,a5,s0
     e60:	00279793          	slli	a5,a5,0x2
     e64:	002787b3          	add	a5,a5,sp
     e68:	0447d603          	lhu	a2,68(a5)
     e6c:	00040593          	mv	a1,s0
     e70:	00090513          	mv	a0,s2
     e74:	421010ef          	jal	2a94 <ee_printf>
     e78:	00140413          	addi	s0,s0,1
     e7c:	010c2783          	lw	a5,16(s8)
     e80:	01041413          	slli	s0,s0,0x10
     e84:	01045413          	srli	s0,s0,0x10
     e88:	fcf468e3          	bltu	s0,a5,e58 <main+0x5e0>
     e8c:	0a048663          	beqz	s1,f38 <main+0x6c0>
     e90:	0a905c63          	blez	s1,f48 <main+0x6d0>
     e94:	00004537          	lui	a0,0x4
     e98:	c6c50513          	addi	a0,a0,-916 # 3c6c <memcpy+0x790>
     e9c:	3f9010ef          	jal	2a94 <ee_printf>
     ea0:	04e10513          	addi	a0,sp,78
     ea4:	199000ef          	jal	183c <portable_fini>
     ea8:	07c12083          	lw	ra,124(sp)
     eac:	07812403          	lw	s0,120(sp)
     eb0:	07412483          	lw	s1,116(sp)
     eb4:	07012903          	lw	s2,112(sp)
     eb8:	06412a83          	lw	s5,100(sp)
     ebc:	06012b03          	lw	s6,96(sp)
     ec0:	05812c03          	lw	s8,88(sp)
     ec4:	00000513          	li	a0,0
     ec8:	08010113          	addi	sp,sp,128
     ecc:	00008067          	ret
     ed0:	00004537          	lui	a0,0x4
     ed4:	95c50513          	addi	a0,a0,-1700 # 395c <memcpy+0x480>
     ed8:	000b8593          	mv	a1,s7
     edc:	3b9010ef          	jal	2a94 <ee_printf>
     ee0:	ffc45783          	lhu	a5,-4(s0)
     ee4:	00178793          	addi	a5,a5,1
     ee8:	01079793          	slli	a5,a5,0x10
     eec:	0107d793          	srli	a5,a5,0x10
     ef0:	fef41e23          	sh	a5,-4(s0)
     ef4:	c59ff06f          	j	b4c <main+0x2d4>
     ef8:	00004537          	lui	a0,0x4
     efc:	9f850513          	addi	a0,a0,-1544 # 39f8 <memcpy+0x51c>
     f00:	395010ef          	jal	2a94 <ee_printf>
     f04:	00148493          	addi	s1,s1,1
     f08:	dd5ff06f          	j	cdc <main+0x464>
     f0c:	02812403          	lw	s0,40(sp)
     f10:	010c2783          	lw	a5,16(s8)
     f14:	000a8513          	mv	a0,s5
     f18:	02f40433          	mul	s0,s0,a5
     f1c:	0c9000ef          	jal	17e4 <time_in_secs>
     f20:	00050593          	mv	a1,a0
     f24:	00004537          	lui	a0,0x4
     f28:	9e050513          	addi	a0,a0,-1568 # 39e0 <memcpy+0x504>
     f2c:	02b455b3          	divu	a1,s0,a1
     f30:	365010ef          	jal	2a94 <ee_printf>
     f34:	d99ff06f          	j	ccc <main+0x454>
     f38:	00004537          	lui	a0,0x4
     f3c:	bbc50513          	addi	a0,a0,-1092 # 3bbc <memcpy+0x6e0>
     f40:	355010ef          	jal	2a94 <ee_printf>
     f44:	f5dff06f          	j	ea0 <main+0x628>
     f48:	00004537          	lui	a0,0x4
     f4c:	c0850513          	addi	a0,a0,-1016 # 3c08 <memcpy+0x72c>
     f50:	345010ef          	jal	2a94 <ee_printf>
     f54:	f4dff06f          	j	ea0 <main+0x628>
     f58:	00004537          	lui	a0,0x4
     f5c:	8c850513          	addi	a0,a0,-1848 # 38c8 <memcpy+0x3ec>
     f60:	335010ef          	jal	2a94 <ee_printf>
     f64:	00400913          	li	s2,4
     f68:	b95ff06f          	j	afc <main+0x284>
     f6c:	00004537          	lui	a0,0x4
     f70:	83450513          	addi	a0,a0,-1996 # 3834 <memcpy+0x358>
     f74:	321010ef          	jal	2a94 <ee_printf>
     f78:	00100913          	li	s2,1
     f7c:	b81ff06f          	j	afc <main+0x284>
     f80:	00004537          	lui	a0,0x4
     f84:	80450513          	addi	a0,a0,-2044 # 3804 <memcpy+0x328>
     f88:	30d010ef          	jal	2a94 <ee_printf>
     f8c:	00000913          	li	s2,0
     f90:	b6dff06f          	j	afc <main+0x284>
     f94:	01011783          	lh	a5,16(sp)
     f98:	960794e3          	bnez	a5,900 <main+0x88>
     f9c:	341537b7          	lui	a5,0x34153
     fa0:	41578793          	addi	a5,a5,1045 # 34153415 <_stack_start+0x3414b415>
     fa4:	06600713          	li	a4,102
     fa8:	00f12623          	sw	a5,12(sp)
     fac:	00e11823          	sh	a4,16(sp)
     fb0:	951ff06f          	j	900 <main+0x88>
     fb4:	00000493          	li	s1,0
     fb8:	cc9ff06f          	j	c80 <main+0x408>
     fbc:	0047f793          	andi	a5,a5,4
     fc0:	e80782e3          	beqz	a5,e44 <main+0x5cc>
     fc4:	ec9ff06f          	j	e8c <main+0x614>

00000fc8 <core_init_matrix>:
     fc8:	ff010113          	addi	sp,sp,-16
     fcc:	00812623          	sw	s0,12(sp)
     fd0:	00912423          	sw	s1,8(sp)
     fd4:	00050813          	mv	a6,a0
     fd8:	00061463          	bnez	a2,fe0 <core_init_matrix+0x18>
     fdc:	00100613          	li	a2,1
     fe0:	fff58413          	addi	s0,a1,-1
     fe4:	ffc47413          	andi	s0,s0,-4
     fe8:	00440393          	addi	t2,s0,4
     fec:	00000793          	li	a5,0
     ff0:	0c080c63          	beqz	a6,10c8 <core_init_matrix+0x100>
     ff4:	00078513          	mv	a0,a5
     ff8:	00178793          	addi	a5,a5,1
     ffc:	02f78733          	mul	a4,a5,a5
    1000:	00371713          	slli	a4,a4,0x3
    1004:	ff0768e3          	bltu	a4,a6,ff4 <core_init_matrix+0x2c>
    1008:	02a502b3          	mul	t0,a0,a0
    100c:	00129293          	slli	t0,t0,0x1
    1010:	00538433          	add	s0,t2,t0
    1014:	0c050663          	beqz	a0,10e0 <core_init_matrix+0x118>
    1018:	01212223          	sw	s2,4(sp)
    101c:	00050493          	mv	s1,a0
    1020:	00150313          	addi	t1,a0,1
    1024:	00151913          	slli	s2,a0,0x1
    1028:	00040f13          	mv	t5,s0
    102c:	00000e93          	li	t4,0
    1030:	00100793          	li	a5,1
    1034:	40838e33          	sub	t3,t2,s0
    1038:	00078f93          	mv	t6,a5
    103c:	000f0593          	mv	a1,t5
    1040:	02f60633          	mul	a2,a2,a5
    1044:	00be08b3          	add	a7,t3,a1
    1048:	00258593          	addi	a1,a1,2
    104c:	41f65713          	srai	a4,a2,0x1f
    1050:	01075713          	srli	a4,a4,0x10
    1054:	00e60633          	add	a2,a2,a4
    1058:	01061613          	slli	a2,a2,0x10
    105c:	01065613          	srli	a2,a2,0x10
    1060:	40e60633          	sub	a2,a2,a4
    1064:	00c78833          	add	a6,a5,a2
    1068:	00f80733          	add	a4,a6,a5
    106c:	ff059f23          	sh	a6,-2(a1)
    1070:	0ff77713          	zext.b	a4,a4
    1074:	00178793          	addi	a5,a5,1
    1078:	00e89023          	sh	a4,0(a7)
    107c:	fc6792e3          	bne	a5,t1,1040 <core_init_matrix+0x78>
    1080:	001e8e93          	addi	t4,t4,1
    1084:	01f507b3          	add	a5,a0,t6
    1088:	00a30333          	add	t1,t1,a0
    108c:	012f0f33          	add	t5,t5,s2
    1090:	faae94e3          	bne	t4,a0,1038 <core_init_matrix+0x70>
    1094:	00412903          	lw	s2,4(sp)
    1098:	005407b3          	add	a5,s0,t0
    109c:	fff78793          	addi	a5,a5,-1
    10a0:	0086a423          	sw	s0,8(a3)
    10a4:	ffc7f793          	andi	a5,a5,-4
    10a8:	00c12403          	lw	s0,12(sp)
    10ac:	00478793          	addi	a5,a5,4
    10b0:	0096a023          	sw	s1,0(a3)
    10b4:	00f6a623          	sw	a5,12(a3)
    10b8:	0076a223          	sw	t2,4(a3)
    10bc:	00812483          	lw	s1,8(sp)
    10c0:	01010113          	addi	sp,sp,16
    10c4:	00008067          	ret
    10c8:	fff00493          	li	s1,-1
    10cc:	01212223          	sw	s2,4(sp)
    10d0:	00640413          	addi	s0,s0,6
    10d4:	00048513          	mv	a0,s1
    10d8:	00200293          	li	t0,2
    10dc:	f45ff06f          	j	1020 <core_init_matrix+0x58>
    10e0:	00000293          	li	t0,0
    10e4:	00000493          	li	s1,0
    10e8:	fb1ff06f          	j	1098 <core_init_matrix+0xd0>

000010ec <matrix_mul_vect>:
    10ec:	04050a63          	beqz	a0,1140 <matrix_mul_vect+0x54>
    10f0:	00251f13          	slli	t5,a0,0x2
    10f4:	00151e13          	slli	t3,a0,0x1
    10f8:	01e58f33          	add	t5,a1,t5
    10fc:	01c68e33          	add	t3,a3,t3
    1100:	00000e93          	li	t4,0
    1104:	001e9813          	slli	a6,t4,0x1
    1108:	01060833          	add	a6,a2,a6
    110c:	00068793          	mv	a5,a3
    1110:	00000893          	li	a7,0
    1114:	00081703          	lh	a4,0(a6)
    1118:	00079303          	lh	t1,0(a5)
    111c:	00278793          	addi	a5,a5,2
    1120:	00280813          	addi	a6,a6,2
    1124:	02670733          	mul	a4,a4,t1
    1128:	00e888b3          	add	a7,a7,a4
    112c:	fefe14e3          	bne	t3,a5,1114 <matrix_mul_vect+0x28>
    1130:	0115a023          	sw	a7,0(a1)
    1134:	00458593          	addi	a1,a1,4
    1138:	00ae8eb3          	add	t4,t4,a0
    113c:	fcbf14e3          	bne	t5,a1,1104 <matrix_mul_vect+0x18>
    1140:	00008067          	ret

00001144 <matrix_mul_matrix>:
    1144:	08050e63          	beqz	a0,11e0 <matrix_mul_matrix+0x9c>
    1148:	ff010113          	addi	sp,sp,-16
    114c:	00151313          	slli	t1,a0,0x1
    1150:	00812623          	sw	s0,12(sp)
    1154:	00060293          	mv	t0,a2
    1158:	00068413          	mv	s0,a3
    115c:	00660e33          	add	t3,a2,t1
    1160:	00000393          	li	t2,0
    1164:	00000693          	li	a3,0
    1168:	00239e93          	slli	t4,t2,0x2
    116c:	01d58eb3          	add	t4,a1,t4
    1170:	00040f13          	mv	t5,s0
    1174:	00000f93          	li	t6,0
    1178:	000f0613          	mv	a2,t5
    117c:	00028793          	mv	a5,t0
    1180:	00000813          	li	a6,0
    1184:	00079703          	lh	a4,0(a5)
    1188:	00061883          	lh	a7,0(a2)
    118c:	00278793          	addi	a5,a5,2
    1190:	00660633          	add	a2,a2,t1
    1194:	03170733          	mul	a4,a4,a7
    1198:	00e80833          	add	a6,a6,a4
    119c:	fefe14e3          	bne	t3,a5,1184 <matrix_mul_matrix+0x40>
    11a0:	010ea023          	sw	a6,0(t4)
    11a4:	001f8793          	addi	a5,t6,1 # ffff8001 <_stack_start+0xffff0001>
    11a8:	004e8e93          	addi	t4,t4,4
    11ac:	002f0f13          	addi	t5,t5,2
    11b0:	00f50663          	beq	a0,a5,11bc <matrix_mul_matrix+0x78>
    11b4:	00078f93          	mv	t6,a5
    11b8:	fc1ff06f          	j	1178 <matrix_mul_matrix+0x34>
    11bc:	006282b3          	add	t0,t0,t1
    11c0:	00a383b3          	add	t2,t2,a0
    11c4:	006e0e33          	add	t3,t3,t1
    11c8:	01f68663          	beq	a3,t6,11d4 <matrix_mul_matrix+0x90>
    11cc:	00168693          	addi	a3,a3,1
    11d0:	f99ff06f          	j	1168 <matrix_mul_matrix+0x24>
    11d4:	00c12403          	lw	s0,12(sp)
    11d8:	01010113          	addi	sp,sp,16
    11dc:	00008067          	ret
    11e0:	00008067          	ret

000011e4 <matrix_mul_matrix_bitextract>:
    11e4:	0a050863          	beqz	a0,1294 <matrix_mul_matrix_bitextract+0xb0>
    11e8:	ff010113          	addi	sp,sp,-16
    11ec:	00151313          	slli	t1,a0,0x1
    11f0:	00812623          	sw	s0,12(sp)
    11f4:	00060293          	mv	t0,a2
    11f8:	00068413          	mv	s0,a3
    11fc:	00660e33          	add	t3,a2,t1
    1200:	00000393          	li	t2,0
    1204:	00000693          	li	a3,0
    1208:	00239e93          	slli	t4,t2,0x2
    120c:	01d58eb3          	add	t4,a1,t4
    1210:	00040f13          	mv	t5,s0
    1214:	00000f93          	li	t6,0
    1218:	000f0813          	mv	a6,t5
    121c:	00028613          	mv	a2,t0
    1220:	00000893          	li	a7,0
    1224:	00081703          	lh	a4,0(a6)
    1228:	00061783          	lh	a5,0(a2)
    122c:	00260613          	addi	a2,a2,2
    1230:	00680833          	add	a6,a6,t1
    1234:	02e787b3          	mul	a5,a5,a4
    1238:	4027d713          	srai	a4,a5,0x2
    123c:	4057d793          	srai	a5,a5,0x5
    1240:	00f77713          	andi	a4,a4,15
    1244:	07f7f793          	andi	a5,a5,127
    1248:	02f707b3          	mul	a5,a4,a5
    124c:	00f888b3          	add	a7,a7,a5
    1250:	fcce1ae3          	bne	t3,a2,1224 <matrix_mul_matrix_bitextract+0x40>
    1254:	011ea023          	sw	a7,0(t4)
    1258:	001f8793          	addi	a5,t6,1
    125c:	004e8e93          	addi	t4,t4,4
    1260:	002f0f13          	addi	t5,t5,2
    1264:	00f50663          	beq	a0,a5,1270 <matrix_mul_matrix_bitextract+0x8c>
    1268:	00078f93          	mv	t6,a5
    126c:	fadff06f          	j	1218 <matrix_mul_matrix_bitextract+0x34>
    1270:	006282b3          	add	t0,t0,t1
    1274:	00a383b3          	add	t2,t2,a0
    1278:	006e0e33          	add	t3,t3,t1
    127c:	01f68663          	beq	a3,t6,1288 <matrix_mul_matrix_bitextract+0xa4>
    1280:	00168693          	addi	a3,a3,1
    1284:	f85ff06f          	j	1208 <matrix_mul_matrix_bitextract+0x24>
    1288:	00c12403          	lw	s0,12(sp)
    128c:	01010113          	addi	sp,sp,16
    1290:	00008067          	ret
    1294:	00008067          	ret

00001298 <matrix_test>:
    1298:	fd010113          	addi	sp,sp,-48
    129c:	03212023          	sw	s2,32(sp)
    12a0:	01312e23          	sw	s3,28(sp)
    12a4:	01512a23          	sw	s5,20(sp)
    12a8:	02112623          	sw	ra,44(sp)
    12ac:	02812423          	sw	s0,40(sp)
    12b0:	00058a93          	mv	s5,a1
    12b4:	00060913          	mv	s2,a2
    12b8:	00068993          	mv	s3,a3
    12bc:	34050663          	beqz	a0,1608 <matrix_test+0x370>
    12c0:	00151593          	slli	a1,a0,0x1
    12c4:	02912223          	sw	s1,36(sp)
    12c8:	01412c23          	sw	s4,24(sp)
    12cc:	00b60633          	add	a2,a2,a1
    12d0:	00070a13          	mv	s4,a4
    12d4:	fffff4b7          	lui	s1,0xfffff
    12d8:	01612823          	sw	s6,16(sp)
    12dc:	01712623          	sw	s7,12(sp)
    12e0:	01812423          	sw	s8,8(sp)
    12e4:	01912223          	sw	s9,4(sp)
    12e8:	00060713          	mv	a4,a2
    12ec:	009a64b3          	or	s1,s4,s1
    12f0:	00000b13          	li	s6,0
    12f4:	40b707b3          	sub	a5,a4,a1
    12f8:	0007d683          	lhu	a3,0(a5)
    12fc:	00278793          	addi	a5,a5,2
    1300:	00da06b3          	add	a3,s4,a3
    1304:	fed79f23          	sh	a3,-2(a5)
    1308:	fee798e3          	bne	a5,a4,12f8 <matrix_test+0x60>
    130c:	001b0413          	addi	s0,s6,1
    1310:	00b78733          	add	a4,a5,a1
    1314:	00850663          	beq	a0,s0,1320 <matrix_test+0x88>
    1318:	00040b13          	mv	s6,s0
    131c:	fd9ff06f          	j	12f4 <matrix_test+0x5c>
    1320:	00000513          	li	a0,0
    1324:	00000813          	li	a6,0
    1328:	00251713          	slli	a4,a0,0x2
    132c:	00ea8733          	add	a4,s5,a4
    1330:	40b607b3          	sub	a5,a2,a1
    1334:	00079683          	lh	a3,0(a5)
    1338:	00278793          	addi	a5,a5,2
    133c:	00470713          	addi	a4,a4,4
    1340:	034686b3          	mul	a3,a3,s4
    1344:	fed72e23          	sw	a3,-4(a4)
    1348:	fef616e3          	bne	a2,a5,1334 <matrix_test+0x9c>
    134c:	00850533          	add	a0,a0,s0
    1350:	00b60633          	add	a2,a2,a1
    1354:	01680663          	beq	a6,s6,1360 <matrix_test+0xc8>
    1358:	00180813          	addi	a6,a6,1
    135c:	fcdff06f          	j	1328 <matrix_test+0x90>
    1360:	00241c13          	slli	s8,s0,0x2
    1364:	018a8bb3          	add	s7,s5,s8
    1368:	000b8813          	mv	a6,s7
    136c:	00000693          	li	a3,0
    1370:	00000713          	li	a4,0
    1374:	00000513          	li	a0,0
    1378:	00000893          	li	a7,0
    137c:	418807b3          	sub	a5,a6,s8
    1380:	0180006f          	j	1398 <matrix_test+0x100>
    1384:	00c505b3          	add	a1,a0,a2
    1388:	01059513          	slli	a0,a1,0x10
    138c:	00478793          	addi	a5,a5,4
    1390:	41055513          	srai	a0,a0,0x10
    1394:	02f80863          	beq	a6,a5,13c4 <matrix_test+0x12c>
    1398:	00068613          	mv	a2,a3
    139c:	0007a683          	lw	a3,0(a5)
    13a0:	00a50593          	addi	a1,a0,10
    13a4:	00d70733          	add	a4,a4,a3
    13a8:	00d62633          	slt	a2,a2,a3
    13ac:	fce4dce3          	bge	s1,a4,1384 <matrix_test+0xec>
    13b0:	01059513          	slli	a0,a1,0x10
    13b4:	00478793          	addi	a5,a5,4
    13b8:	00000713          	li	a4,0
    13bc:	41055513          	srai	a0,a0,0x10
    13c0:	fcf81ce3          	bne	a6,a5,1398 <matrix_test+0x100>
    13c4:	01880833          	add	a6,a6,s8
    13c8:	011b0663          	beq	s6,a7,13d4 <matrix_test+0x13c>
    13cc:	00188893          	addi	a7,a7,1
    13d0:	fadff06f          	j	137c <matrix_test+0xe4>
    13d4:	00000593          	li	a1,0
    13d8:	148010ef          	jal	2520 <crc16>
    13dc:	00098693          	mv	a3,s3
    13e0:	00050c93          	mv	s9,a0
    13e4:	00090613          	mv	a2,s2
    13e8:	00040513          	mv	a0,s0
    13ec:	000a8593          	mv	a1,s5
    13f0:	cfdff0ef          	jal	10ec <matrix_mul_vect>
    13f4:	00000693          	li	a3,0
    13f8:	00000713          	li	a4,0
    13fc:	00000513          	li	a0,0
    1400:	00000813          	li	a6,0
    1404:	418b87b3          	sub	a5,s7,s8
    1408:	0180006f          	j	1420 <matrix_test+0x188>
    140c:	00c505b3          	add	a1,a0,a2
    1410:	01059513          	slli	a0,a1,0x10
    1414:	00478793          	addi	a5,a5,4
    1418:	41055513          	srai	a0,a0,0x10
    141c:	03778863          	beq	a5,s7,144c <matrix_test+0x1b4>
    1420:	00068613          	mv	a2,a3
    1424:	0007a683          	lw	a3,0(a5)
    1428:	00a50593          	addi	a1,a0,10
    142c:	00d70733          	add	a4,a4,a3
    1430:	00d62633          	slt	a2,a2,a3
    1434:	fce4dce3          	bge	s1,a4,140c <matrix_test+0x174>
    1438:	01059513          	slli	a0,a1,0x10
    143c:	00478793          	addi	a5,a5,4
    1440:	00000713          	li	a4,0
    1444:	41055513          	srai	a0,a0,0x10
    1448:	fd779ce3          	bne	a5,s7,1420 <matrix_test+0x188>
    144c:	01878bb3          	add	s7,a5,s8
    1450:	01680663          	beq	a6,s6,145c <matrix_test+0x1c4>
    1454:	00180813          	addi	a6,a6,1
    1458:	fadff06f          	j	1404 <matrix_test+0x16c>
    145c:	000c8593          	mv	a1,s9
    1460:	0c0010ef          	jal	2520 <crc16>
    1464:	00098693          	mv	a3,s3
    1468:	00050b13          	mv	s6,a0
    146c:	00090613          	mv	a2,s2
    1470:	00040513          	mv	a0,s0
    1474:	000a8593          	mv	a1,s5
    1478:	ccdff0ef          	jal	1144 <matrix_mul_matrix>
    147c:	00000313          	li	t1,0
    1480:	00000793          	li	a5,0
    1484:	00000693          	li	a3,0
    1488:	00000513          	li	a0,0
    148c:	00000893          	li	a7,0
    1490:	00231613          	slli	a2,t1,0x2
    1494:	00ca8633          	add	a2,s5,a2
    1498:	00000593          	li	a1,0
    149c:	01c0006f          	j	14b8 <matrix_test+0x220>
    14a0:	00e50833          	add	a6,a0,a4
    14a4:	01081513          	slli	a0,a6,0x10
    14a8:	00158593          	addi	a1,a1,1
    14ac:	41055513          	srai	a0,a0,0x10
    14b0:	00460613          	addi	a2,a2,4
    14b4:	0285fa63          	bgeu	a1,s0,14e8 <matrix_test+0x250>
    14b8:	00078713          	mv	a4,a5
    14bc:	00062783          	lw	a5,0(a2)
    14c0:	00a50813          	addi	a6,a0,10
    14c4:	00f686b3          	add	a3,a3,a5
    14c8:	00f72733          	slt	a4,a4,a5
    14cc:	fcd4dae3          	bge	s1,a3,14a0 <matrix_test+0x208>
    14d0:	01081513          	slli	a0,a6,0x10
    14d4:	00158593          	addi	a1,a1,1
    14d8:	00000693          	li	a3,0
    14dc:	41055513          	srai	a0,a0,0x10
    14e0:	00460613          	addi	a2,a2,4
    14e4:	fc85eae3          	bltu	a1,s0,14b8 <matrix_test+0x220>
    14e8:	00188893          	addi	a7,a7,1
    14ec:	00830333          	add	t1,t1,s0
    14f0:	fa88e0e3          	bltu	a7,s0,1490 <matrix_test+0x1f8>
    14f4:	000b0593          	mv	a1,s6
    14f8:	028010ef          	jal	2520 <crc16>
    14fc:	00098693          	mv	a3,s3
    1500:	00050b13          	mv	s6,a0
    1504:	00090613          	mv	a2,s2
    1508:	00040513          	mv	a0,s0
    150c:	000a8593          	mv	a1,s5
    1510:	cd5ff0ef          	jal	11e4 <matrix_mul_matrix_bitextract>
    1514:	00000313          	li	t1,0
    1518:	00000793          	li	a5,0
    151c:	00000693          	li	a3,0
    1520:	00000513          	li	a0,0
    1524:	00000893          	li	a7,0
    1528:	00231613          	slli	a2,t1,0x2
    152c:	00ca8633          	add	a2,s5,a2
    1530:	00000593          	li	a1,0
    1534:	01c0006f          	j	1550 <matrix_test+0x2b8>
    1538:	00e50833          	add	a6,a0,a4
    153c:	01081513          	slli	a0,a6,0x10
    1540:	00158593          	addi	a1,a1,1
    1544:	41055513          	srai	a0,a0,0x10
    1548:	00460613          	addi	a2,a2,4
    154c:	0285fa63          	bgeu	a1,s0,1580 <matrix_test+0x2e8>
    1550:	00078713          	mv	a4,a5
    1554:	00062783          	lw	a5,0(a2)
    1558:	00a50813          	addi	a6,a0,10
    155c:	00f686b3          	add	a3,a3,a5
    1560:	00f72733          	slt	a4,a4,a5
    1564:	fcd4dae3          	bge	s1,a3,1538 <matrix_test+0x2a0>
    1568:	01081513          	slli	a0,a6,0x10
    156c:	00158593          	addi	a1,a1,1
    1570:	00000693          	li	a3,0
    1574:	41055513          	srai	a0,a0,0x10
    1578:	00460613          	addi	a2,a2,4
    157c:	fc85eae3          	bltu	a1,s0,1550 <matrix_test+0x2b8>
    1580:	00188893          	addi	a7,a7,1
    1584:	00830333          	add	t1,t1,s0
    1588:	fa88e0e3          	bltu	a7,s0,1528 <matrix_test+0x290>
    158c:	000b0593          	mv	a1,s6
    1590:	791000ef          	jal	2520 <crc16>
    1594:	00000593          	li	a1,0
    1598:	00000613          	li	a2,0
    159c:	00159793          	slli	a5,a1,0x1
    15a0:	00f907b3          	add	a5,s2,a5
    15a4:	00000713          	li	a4,0
    15a8:	0007d683          	lhu	a3,0(a5)
    15ac:	00170713          	addi	a4,a4,1
    15b0:	00278793          	addi	a5,a5,2
    15b4:	414686b3          	sub	a3,a3,s4
    15b8:	fed79f23          	sh	a3,-2(a5)
    15bc:	fe8766e3          	bltu	a4,s0,15a8 <matrix_test+0x310>
    15c0:	00160613          	addi	a2,a2,1
    15c4:	008585b3          	add	a1,a1,s0
    15c8:	fc866ae3          	bltu	a2,s0,159c <matrix_test+0x304>
    15cc:	02412483          	lw	s1,36(sp)
    15d0:	01812a03          	lw	s4,24(sp)
    15d4:	01012b03          	lw	s6,16(sp)
    15d8:	00c12b83          	lw	s7,12(sp)
    15dc:	00812c03          	lw	s8,8(sp)
    15e0:	00412c83          	lw	s9,4(sp)
    15e4:	02c12083          	lw	ra,44(sp)
    15e8:	02812403          	lw	s0,40(sp)
    15ec:	01051513          	slli	a0,a0,0x10
    15f0:	02012903          	lw	s2,32(sp)
    15f4:	01c12983          	lw	s3,28(sp)
    15f8:	01412a83          	lw	s5,20(sp)
    15fc:	41055513          	srai	a0,a0,0x10
    1600:	03010113          	addi	sp,sp,48
    1604:	00008067          	ret
    1608:	00000593          	li	a1,0
    160c:	715000ef          	jal	2520 <crc16>
    1610:	00098693          	mv	a3,s3
    1614:	00090613          	mv	a2,s2
    1618:	00050413          	mv	s0,a0
    161c:	000a8593          	mv	a1,s5
    1620:	00000513          	li	a0,0
    1624:	ac9ff0ef          	jal	10ec <matrix_mul_vect>
    1628:	00040593          	mv	a1,s0
    162c:	00000513          	li	a0,0
    1630:	6f1000ef          	jal	2520 <crc16>
    1634:	00098693          	mv	a3,s3
    1638:	00090613          	mv	a2,s2
    163c:	00050413          	mv	s0,a0
    1640:	000a8593          	mv	a1,s5
    1644:	00000513          	li	a0,0
    1648:	afdff0ef          	jal	1144 <matrix_mul_matrix>
    164c:	00040593          	mv	a1,s0
    1650:	00000513          	li	a0,0
    1654:	6cd000ef          	jal	2520 <crc16>
    1658:	00050413          	mv	s0,a0
    165c:	000a8593          	mv	a1,s5
    1660:	00098693          	mv	a3,s3
    1664:	00090613          	mv	a2,s2
    1668:	00000513          	li	a0,0
    166c:	b79ff0ef          	jal	11e4 <matrix_mul_matrix_bitextract>
    1670:	00040593          	mv	a1,s0
    1674:	00000513          	li	a0,0
    1678:	6a9000ef          	jal	2520 <crc16>
    167c:	f69ff06f          	j	15e4 <matrix_test+0x34c>

00001680 <core_bench_matrix>:
    1680:	ff010113          	addi	sp,sp,-16
    1684:	00812423          	sw	s0,8(sp)
    1688:	00852683          	lw	a3,8(a0)
    168c:	00060413          	mv	s0,a2
    1690:	00058713          	mv	a4,a1
    1694:	00452603          	lw	a2,4(a0)
    1698:	00c52583          	lw	a1,12(a0)
    169c:	00052503          	lw	a0,0(a0)
    16a0:	00112623          	sw	ra,12(sp)
    16a4:	bf5ff0ef          	jal	1298 <matrix_test>
    16a8:	00040593          	mv	a1,s0
    16ac:	00812403          	lw	s0,8(sp)
    16b0:	00c12083          	lw	ra,12(sp)
    16b4:	01010113          	addi	sp,sp,16
    16b8:	6690006f          	j	2520 <crc16>

000016bc <output_data>:
    16bc:	00050793          	mv	a5,a0
    16c0:	00058713          	mv	a4,a1
    16c4:	00078513          	mv	a0,a5
    16c8:	00070593          	mv	a1,a4
    16cc:	00b50533          	add	a0,a0,a1
    16d0:	00400793          	li	a5,4
    16d4:	02f60a63          	beq	a2,a5,1708 <output_data+0x4c>
    16d8:	00c7ec63          	bltu	a5,a2,16f0 <output_data+0x34>
    16dc:	02060a63          	beqz	a2,1710 <output_data+0x54>
    16e0:	00100793          	li	a5,1
    16e4:	00f61e63          	bne	a2,a5,1700 <output_data+0x44>
    16e8:	00051008          	.word	0x00051008
    16ec:	00008067          	ret
    16f0:	00500793          	li	a5,5
    16f4:	00f61663          	bne	a2,a5,1700 <output_data+0x44>
    16f8:	00055008          	.word	0x00055008
    16fc:	00008067          	ret
    1700:	00052008          	.word	0x00052008
    1704:	00008067          	ret
    1708:	00054008          	.word	0x00054008
    170c:	00008067          	ret
    1710:	00050008          	.word	0x00050008
    1714:	00008067          	ret

00001718 <input_data>:
    1718:	00050793          	mv	a5,a0
    171c:	00058713          	mv	a4,a1
    1720:	00f70533          	add	a0,a4,a5
    1724:	00400793          	li	a5,4
    1728:	00f60e63          	beq	a2,a5,1744 <input_data+0x2c>
    172c:	00500793          	li	a5,5
    1730:	00f60663          	beq	a2,a5,173c <input_data+0x24>
    1734:	00a52077          	.word	0x00a52077
    1738:	00008067          	ret
    173c:	00051077          	.word	0x00051077
    1740:	00008067          	ret
    1744:	00050077          	.word	0x00050077
    1748:	00008067          	ret

0000174c <start_time>:
    174c:	fe010113          	addi	sp,sp,-32
    1750:	00200613          	li	a2,2
    1754:	00000593          	li	a1,0
    1758:	00c10513          	addi	a0,sp,12
    175c:	00112e23          	sw	ra,28(sp)
    1760:	00012623          	sw	zero,12(sp)
    1764:	fb5ff0ef          	jal	1718 <input_data>
    1768:	00000293          	li	t0,0
    176c:	0002a783          	lw	a5,0(t0)
    1770:	00f12623          	sw	a5,12(sp)
    1774:	00c12703          	lw	a4,12(sp)
    1778:	01c12083          	lw	ra,28(sp)
    177c:	000047b7          	lui	a5,0x4
    1780:	7ee7a823          	sw	a4,2032(a5) # 47f0 <start_time_val>
    1784:	02010113          	addi	sp,sp,32
    1788:	00008067          	ret

0000178c <stop_time>:
    178c:	fe010113          	addi	sp,sp,-32
    1790:	00200613          	li	a2,2
    1794:	00000593          	li	a1,0
    1798:	00c10513          	addi	a0,sp,12
    179c:	00112e23          	sw	ra,28(sp)
    17a0:	00012623          	sw	zero,12(sp)
    17a4:	f75ff0ef          	jal	1718 <input_data>
    17a8:	00000293          	li	t0,0
    17ac:	0002a783          	lw	a5,0(t0)
    17b0:	00f12623          	sw	a5,12(sp)
    17b4:	00c12703          	lw	a4,12(sp)
    17b8:	01c12083          	lw	ra,28(sp)
    17bc:	000047b7          	lui	a5,0x4
    17c0:	7ee7a623          	sw	a4,2028(a5) # 47ec <stop_time_val>
    17c4:	02010113          	addi	sp,sp,32
    17c8:	00008067          	ret

000017cc <get_time>:
    17cc:	00004737          	lui	a4,0x4
    17d0:	000047b7          	lui	a5,0x4
    17d4:	7ec72503          	lw	a0,2028(a4) # 47ec <stop_time_val>
    17d8:	7f07a783          	lw	a5,2032(a5) # 47f0 <start_time_val>
    17dc:	40f50533          	sub	a0,a0,a5
    17e0:	00008067          	ret

000017e4 <time_in_secs>:
    17e4:	55e647b7          	lui	a5,0x55e64
    17e8:	b8978793          	addi	a5,a5,-1143 # 55e63b89 <_stack_start+0x55e5bb89>
    17ec:	02f53533          	mulhu	a0,a0,a5
    17f0:	01855513          	srli	a0,a0,0x18
    17f4:	00008067          	ret

000017f8 <portable_init>:
    17f8:	fe010113          	addi	sp,sp,-32
    17fc:	00812c23          	sw	s0,24(sp)
    1800:	00050413          	mv	s0,a0
    1804:	00300513          	li	a0,3
    1808:	00112e23          	sw	ra,28(sp)
    180c:	359010ef          	jal	3364 <uart_enable>
    1810:	00c10513          	addi	a0,sp,12
    1814:	00200613          	li	a2,2
    1818:	00000593          	li	a1,0
    181c:	00012623          	sw	zero,12(sp)
    1820:	e9dff0ef          	jal	16bc <output_data>
    1824:	00100793          	li	a5,1
    1828:	00f40023          	sb	a5,0(s0)
    182c:	01c12083          	lw	ra,28(sp)
    1830:	01812403          	lw	s0,24(sp)
    1834:	02010113          	addi	sp,sp,32
    1838:	00008067          	ret

0000183c <portable_fini>:
    183c:	00050023          	sb	zero,0(a0)
    1840:	00008067          	ret

00001844 <core_init_state>:
    1844:	ff010113          	addi	sp,sp,-16
    1848:	00912423          	sw	s1,8(sp)
    184c:	01212223          	sw	s2,4(sp)
    1850:	fff50813          	addi	a6,a0,-1
    1854:	00100e13          	li	t3,1
    1858:	00060893          	mv	a7,a2
    185c:	170e7863          	bgeu	t3,a6,19cc <core_init_state+0x188>
    1860:	01c586b3          	add	a3,a1,t3
    1864:	01069693          	slli	a3,a3,0x10
    1868:	0106d693          	srli	a3,a3,0x10
    186c:	00812623          	sw	s0,12(sp)
    1870:	000042b7          	lui	t0,0x4
    1874:	00004fb7          	lui	t6,0x4
    1878:	00004f37          	lui	t5,0x4
    187c:	00004eb7          	lui	t4,0x4
    1880:	01b69413          	slli	s0,a3,0x1b
    1884:	01312023          	sw	s3,0(sp)
    1888:	00700593          	li	a1,7
    188c:	0076f613          	andi	a2,a3,7
    1890:	d5c28293          	addi	t0,t0,-676 # 3d5c <errpat>
    1894:	d6cf8f93          	addi	t6,t6,-660 # 3d6c <scipat>
    1898:	d7cf0f13          	addi	t5,t5,-644 # 3d7c <floatpat>
    189c:	d8ce8e93          	addi	t4,t4,-628 # 3d8c <intpat>
    18a0:	00000913          	li	s2,0
    18a4:	00400313          	li	t1,4
    18a8:	02c00393          	li	t2,44
    18ac:	01e45793          	srli	a5,s0,0x1e
    18b0:	06b60e63          	beq	a2,a1,192c <core_init_state+0xe8>
    18b4:	0cc36863          	bltu	t1,a2,1984 <core_init_state+0x140>
    18b8:	ffd60613          	addi	a2,a2,-3
    18bc:	01061613          	slli	a2,a2,0x10
    18c0:	01065613          	srli	a2,a2,0x10
    18c4:	00279793          	slli	a5,a5,0x2
    18c8:	0ace6663          	bltu	t3,a2,1974 <core_init_state+0x130>
    18cc:	00ff07b3          	add	a5,t5,a5
    18d0:	0007a783          	lw	a5,0(a5)
    18d4:	00800413          	li	s0,8
    18d8:	00190493          	addi	s1,s2,1
    18dc:	008489b3          	add	s3,s1,s0
    18e0:	0709f463          	bgeu	s3,a6,1948 <core_init_state+0x104>
    18e4:	00168693          	addi	a3,a3,1
    18e8:	01288933          	add	s2,a7,s2
    18ec:	01069693          	slli	a3,a3,0x10
    18f0:	0106d693          	srli	a3,a3,0x10
    18f4:	00090713          	mv	a4,s2
    18f8:	008784b3          	add	s1,a5,s0
    18fc:	0007c603          	lbu	a2,0(a5)
    1900:	00178793          	addi	a5,a5,1
    1904:	00170713          	addi	a4,a4,1
    1908:	fec70fa3          	sb	a2,-1(a4)
    190c:	fef498e3          	bne	s1,a5,18fc <core_init_state+0xb8>
    1910:	00890733          	add	a4,s2,s0
    1914:	00770023          	sb	t2,0(a4)
    1918:	01b69413          	slli	s0,a3,0x1b
    191c:	0076f613          	andi	a2,a3,7
    1920:	00098913          	mv	s2,s3
    1924:	01e45793          	srli	a5,s0,0x1e
    1928:	f8b616e3          	bne	a2,a1,18b4 <core_init_state+0x70>
    192c:	00279793          	slli	a5,a5,0x2
    1930:	00800413          	li	s0,8
    1934:	00190493          	addi	s1,s2,1
    1938:	00f287b3          	add	a5,t0,a5
    193c:	008489b3          	add	s3,s1,s0
    1940:	0007a783          	lw	a5,0(a5)
    1944:	fb09e0e3          	bltu	s3,a6,18e4 <core_init_state+0xa0>
    1948:	06a97663          	bgeu	s2,a0,19b4 <core_init_state+0x170>
    194c:	00c12403          	lw	s0,12(sp)
    1950:	00012983          	lw	s3,0(sp)
    1954:	00100613          	li	a2,1
    1958:	04957063          	bgeu	a0,s1,1998 <core_init_state+0x154>
    195c:	00812483          	lw	s1,8(sp)
    1960:	01288533          	add	a0,a7,s2
    1964:	00412903          	lw	s2,4(sp)
    1968:	00000593          	li	a1,0
    196c:	01010113          	addi	sp,sp,16
    1970:	2910106f          	j	3400 <memset>
    1974:	00fe87b3          	add	a5,t4,a5
    1978:	0007a783          	lw	a5,0(a5)
    197c:	00400413          	li	s0,4
    1980:	f59ff06f          	j	18d8 <core_init_state+0x94>
    1984:	00279793          	slli	a5,a5,0x2
    1988:	00ff87b3          	add	a5,t6,a5
    198c:	0007a783          	lw	a5,0(a5)
    1990:	00800413          	li	s0,8
    1994:	f45ff06f          	j	18d8 <core_init_state+0x94>
    1998:	00812483          	lw	s1,8(sp)
    199c:	41250633          	sub	a2,a0,s2
    19a0:	01288533          	add	a0,a7,s2
    19a4:	00412903          	lw	s2,4(sp)
    19a8:	00000593          	li	a1,0
    19ac:	01010113          	addi	sp,sp,16
    19b0:	2510106f          	j	3400 <memset>
    19b4:	00c12403          	lw	s0,12(sp)
    19b8:	00012983          	lw	s3,0(sp)
    19bc:	00812483          	lw	s1,8(sp)
    19c0:	00412903          	lw	s2,4(sp)
    19c4:	01010113          	addi	sp,sp,16
    19c8:	00008067          	ret
    19cc:	000e0493          	mv	s1,t3
    19d0:	00000913          	li	s2,0
    19d4:	f81ff06f          	j	1954 <core_init_state+0x110>

000019d8 <core_state_transition>:
    19d8:	00052703          	lw	a4,0(a0)
    19dc:	00050613          	mv	a2,a0
    19e0:	00074783          	lbu	a5,0(a4)
    19e4:	26078663          	beqz	a5,1c50 <core_state_transition+0x278>
    19e8:	02c00693          	li	a3,44
    19ec:	00000513          	li	a0,0
    19f0:	1cd78c63          	beq	a5,a3,1bc8 <core_state_transition+0x1f0>
    19f4:	02e00813          	li	a6,46
    19f8:	1d078c63          	beq	a5,a6,1bd0 <core_state_transition+0x1f8>
    19fc:	02f86c63          	bltu	a6,a5,1a34 <core_state_transition+0x5c>
    1a00:	fd578793          	addi	a5,a5,-43
    1a04:	0fd7f793          	andi	a5,a5,253
    1a08:	1e078663          	beqz	a5,1bf4 <core_state_transition+0x21c>
    1a0c:	0045a683          	lw	a3,4(a1)
    1a10:	0005a783          	lw	a5,0(a1)
    1a14:	00170713          	addi	a4,a4,1
    1a18:	00168693          	addi	a3,a3,1
    1a1c:	00178793          	addi	a5,a5,1
    1a20:	00d5a223          	sw	a3,4(a1)
    1a24:	00f5a023          	sw	a5,0(a1)
    1a28:	00100513          	li	a0,1
    1a2c:	00e62023          	sw	a4,0(a2)
    1a30:	00008067          	ret
    1a34:	fd078793          	addi	a5,a5,-48
    1a38:	0ff7f793          	zext.b	a5,a5
    1a3c:	00900513          	li	a0,9
    1a40:	fcf566e3          	bltu	a0,a5,1a0c <core_state_transition+0x34>
    1a44:	0005a503          	lw	a0,0(a1)
    1a48:	00170793          	addi	a5,a4,1
    1a4c:	00150513          	addi	a0,a0,1
    1a50:	00a5a023          	sw	a0,0(a1)
    1a54:	00174703          	lbu	a4,1(a4)
    1a58:	1e070663          	beqz	a4,1c44 <core_state_transition+0x26c>
    1a5c:	1ed70e63          	beq	a4,a3,1c58 <core_state_transition+0x280>
    1a60:	02e00693          	li	a3,46
    1a64:	04d70463          	beq	a4,a3,1aac <core_state_transition+0xd4>
    1a68:	fd070713          	addi	a4,a4,-48
    1a6c:	0ff77713          	zext.b	a4,a4
    1a70:	00900693          	li	a3,9
    1a74:	02e6f263          	bgeu	a3,a4,1a98 <core_state_transition+0xc0>
    1a78:	0105a683          	lw	a3,16(a1)
    1a7c:	00100513          	li	a0,1
    1a80:	00178713          	addi	a4,a5,1
    1a84:	00a687b3          	add	a5,a3,a0
    1a88:	00f5a823          	sw	a5,16(a1)
    1a8c:	00e62023          	sw	a4,0(a2)
    1a90:	00008067          	ret
    1a94:	00a5a423          	sw	a0,8(a1)
    1a98:	0017c703          	lbu	a4,1(a5)
    1a9c:	00178793          	addi	a5,a5,1
    1aa0:	1a070263          	beqz	a4,1c44 <core_state_transition+0x26c>
    1aa4:	02c00693          	li	a3,44
    1aa8:	fb5ff06f          	j	1a5c <core_state_transition+0x84>
    1aac:	0105a703          	lw	a4,16(a1)
    1ab0:	00170713          	addi	a4,a4,1
    1ab4:	00e5a823          	sw	a4,16(a1)
    1ab8:	0017c703          	lbu	a4,1(a5)
    1abc:	00178793          	addi	a5,a5,1
    1ac0:	12070463          	beqz	a4,1be8 <core_state_transition+0x210>
    1ac4:	02c00693          	li	a3,44
    1ac8:	0ed70c63          	beq	a4,a3,1bc0 <core_state_transition+0x1e8>
    1acc:	0df77693          	andi	a3,a4,223
    1ad0:	04500513          	li	a0,69
    1ad4:	0ca69263          	bne	a3,a0,1b98 <core_state_transition+0x1c0>
    1ad8:	0145a683          	lw	a3,20(a1)
    1adc:	00178713          	addi	a4,a5,1
    1ae0:	00168693          	addi	a3,a3,1
    1ae4:	00d5aa23          	sw	a3,20(a1)
    1ae8:	0017c683          	lbu	a3,1(a5)
    1aec:	1a068863          	beqz	a3,1c9c <core_state_transition+0x2c4>
    1af0:	02c00513          	li	a0,44
    1af4:	16a68a63          	beq	a3,a0,1c68 <core_state_transition+0x290>
    1af8:	00c5a703          	lw	a4,12(a1)
    1afc:	fd568693          	addi	a3,a3,-43
    1b00:	0fd6f693          	andi	a3,a3,253
    1b04:	00170713          	addi	a4,a4,1
    1b08:	00e5a623          	sw	a4,12(a1)
    1b0c:	08069063          	bnez	a3,1b8c <core_state_transition+0x1b4>
    1b10:	0027c683          	lbu	a3,2(a5)
    1b14:	00278713          	addi	a4,a5,2
    1b18:	14068e63          	beqz	a3,1c74 <core_state_transition+0x29c>
    1b1c:	16a68063          	beq	a3,a0,1c7c <core_state_transition+0x2a4>
    1b20:	0185a503          	lw	a0,24(a1)
    1b24:	fd068693          	addi	a3,a3,-48
    1b28:	0ff6f693          	zext.b	a3,a3
    1b2c:	00150513          	addi	a0,a0,1
    1b30:	00900813          	li	a6,9
    1b34:	00a5ac23          	sw	a0,24(a1)
    1b38:	00d87a63          	bgeu	a6,a3,1b4c <core_state_transition+0x174>
    1b3c:	00378713          	addi	a4,a5,3
    1b40:	00100513          	li	a0,1
    1b44:	00e62023          	sw	a4,0(a2)
    1b48:	00008067          	ret
    1b4c:	00070513          	mv	a0,a4
    1b50:	00174683          	lbu	a3,1(a4)
    1b54:	00170713          	addi	a4,a4,1
    1b58:	02c00893          	li	a7,44
    1b5c:	fd068793          	addi	a5,a3,-48
    1b60:	0ff7f793          	zext.b	a5,a5
    1b64:	12068263          	beqz	a3,1c88 <core_state_transition+0x2b0>
    1b68:	13168463          	beq	a3,a7,1c90 <core_state_transition+0x2b8>
    1b6c:	fef870e3          	bgeu	a6,a5,1b4c <core_state_transition+0x174>
    1b70:	0045a783          	lw	a5,4(a1)
    1b74:	00250713          	addi	a4,a0,2
    1b78:	00100513          	li	a0,1
    1b7c:	00a787b3          	add	a5,a5,a0
    1b80:	00f5a223          	sw	a5,4(a1)
    1b84:	00e62023          	sw	a4,0(a2)
    1b88:	00008067          	ret
    1b8c:	00278713          	addi	a4,a5,2
    1b90:	00100513          	li	a0,1
    1b94:	e99ff06f          	j	1a2c <core_state_transition+0x54>
    1b98:	fd070713          	addi	a4,a4,-48
    1b9c:	0ff77713          	zext.b	a4,a4
    1ba0:	00900693          	li	a3,9
    1ba4:	f0e6fae3          	bgeu	a3,a4,1ab8 <core_state_transition+0xe0>
    1ba8:	0145a683          	lw	a3,20(a1)
    1bac:	00100513          	li	a0,1
    1bb0:	00178713          	addi	a4,a5,1
    1bb4:	00a687b3          	add	a5,a3,a0
    1bb8:	00f5aa23          	sw	a5,20(a1)
    1bbc:	e71ff06f          	j	1a2c <core_state_transition+0x54>
    1bc0:	00078713          	mv	a4,a5
    1bc4:	00500513          	li	a0,5
    1bc8:	00170713          	addi	a4,a4,1
    1bcc:	e61ff06f          	j	1a2c <core_state_transition+0x54>
    1bd0:	0005a503          	lw	a0,0(a1)
    1bd4:	00170793          	addi	a5,a4,1
    1bd8:	00150513          	addi	a0,a0,1
    1bdc:	00a5a023          	sw	a0,0(a1)
    1be0:	00174703          	lbu	a4,1(a4)
    1be4:	ee0712e3          	bnez	a4,1ac8 <core_state_transition+0xf0>
    1be8:	00078713          	mv	a4,a5
    1bec:	00500513          	li	a0,5
    1bf0:	e3dff06f          	j	1a2c <core_state_transition+0x54>
    1bf4:	0005a503          	lw	a0,0(a1)
    1bf8:	00170793          	addi	a5,a4,1
    1bfc:	00150513          	addi	a0,a0,1
    1c00:	00a5a023          	sw	a0,0(a1)
    1c04:	00174303          	lbu	t1,1(a4)
    1c08:	08030e63          	beqz	t1,1ca4 <core_state_transition+0x2cc>
    1c0c:	0ad30263          	beq	t1,a3,1cb0 <core_state_transition+0x2d8>
    1c10:	0085a503          	lw	a0,8(a1)
    1c14:	fd030693          	addi	a3,t1,-48
    1c18:	0ff6f693          	zext.b	a3,a3
    1c1c:	00900893          	li	a7,9
    1c20:	00150513          	addi	a0,a0,1
    1c24:	e6d8f8e3          	bgeu	a7,a3,1a94 <core_state_transition+0xbc>
    1c28:	01030a63          	beq	t1,a6,1c3c <core_state_transition+0x264>
    1c2c:	00a5a423          	sw	a0,8(a1)
    1c30:	00270713          	addi	a4,a4,2
    1c34:	00100513          	li	a0,1
    1c38:	df5ff06f          	j	1a2c <core_state_transition+0x54>
    1c3c:	00a5a423          	sw	a0,8(a1)
    1c40:	e79ff06f          	j	1ab8 <core_state_transition+0xe0>
    1c44:	00078713          	mv	a4,a5
    1c48:	00400513          	li	a0,4
    1c4c:	de1ff06f          	j	1a2c <core_state_transition+0x54>
    1c50:	00000513          	li	a0,0
    1c54:	dd9ff06f          	j	1a2c <core_state_transition+0x54>
    1c58:	00078713          	mv	a4,a5
    1c5c:	00400513          	li	a0,4
    1c60:	00170713          	addi	a4,a4,1
    1c64:	dc9ff06f          	j	1a2c <core_state_transition+0x54>
    1c68:	00300513          	li	a0,3
    1c6c:	00170713          	addi	a4,a4,1
    1c70:	dbdff06f          	j	1a2c <core_state_transition+0x54>
    1c74:	00600513          	li	a0,6
    1c78:	db5ff06f          	j	1a2c <core_state_transition+0x54>
    1c7c:	00600513          	li	a0,6
    1c80:	00170713          	addi	a4,a4,1
    1c84:	da9ff06f          	j	1a2c <core_state_transition+0x54>
    1c88:	00700513          	li	a0,7
    1c8c:	da1ff06f          	j	1a2c <core_state_transition+0x54>
    1c90:	00700513          	li	a0,7
    1c94:	00170713          	addi	a4,a4,1
    1c98:	d95ff06f          	j	1a2c <core_state_transition+0x54>
    1c9c:	00300513          	li	a0,3
    1ca0:	d8dff06f          	j	1a2c <core_state_transition+0x54>
    1ca4:	00078713          	mv	a4,a5
    1ca8:	00200513          	li	a0,2
    1cac:	d81ff06f          	j	1a2c <core_state_transition+0x54>
    1cb0:	00078713          	mv	a4,a5
    1cb4:	00200513          	li	a0,2
    1cb8:	00170713          	addi	a4,a4,1
    1cbc:	d71ff06f          	j	1a2c <core_state_transition+0x54>

00001cc0 <core_bench_state>:
    1cc0:	f8010113          	addi	sp,sp,-128
    1cc4:	06812c23          	sw	s0,120(sp)
    1cc8:	06912a23          	sw	s1,116(sp)
    1ccc:	07212823          	sw	s2,112(sp)
    1cd0:	07312623          	sw	s3,108(sp)
    1cd4:	07412423          	sw	s4,104(sp)
    1cd8:	07512223          	sw	s5,100(sp)
    1cdc:	07612023          	sw	s6,96(sp)
    1ce0:	05712e23          	sw	s7,92(sp)
    1ce4:	05812c23          	sw	s8,88(sp)
    1ce8:	06112e23          	sw	ra,124(sp)
    1cec:	00058493          	mv	s1,a1
    1cf0:	0005c583          	lbu	a1,0(a1)
    1cf4:	03010993          	addi	s3,sp,48
    1cf8:	01010413          	addi	s0,sp,16
    1cfc:	02012823          	sw	zero,48(sp)
    1d00:	00012823          	sw	zero,16(sp)
    1d04:	00912623          	sw	s1,12(sp)
    1d08:	0009a223          	sw	zero,4(s3)
    1d0c:	0009a423          	sw	zero,8(s3)
    1d10:	0009a623          	sw	zero,12(s3)
    1d14:	0009a823          	sw	zero,16(s3)
    1d18:	0009aa23          	sw	zero,20(s3)
    1d1c:	0009ac23          	sw	zero,24(s3)
    1d20:	0009ae23          	sw	zero,28(s3)
    1d24:	00042223          	sw	zero,4(s0)
    1d28:	00042423          	sw	zero,8(s0)
    1d2c:	00042623          	sw	zero,12(s0)
    1d30:	00042823          	sw	zero,16(s0)
    1d34:	00042a23          	sw	zero,20(s0)
    1d38:	00042c23          	sw	zero,24(s0)
    1d3c:	00042e23          	sw	zero,28(s0)
    1d40:	00078913          	mv	s2,a5
    1d44:	00050c13          	mv	s8,a0
    1d48:	00060b93          	mv	s7,a2
    1d4c:	00068b13          	mv	s6,a3
    1d50:	00070a93          	mv	s5,a4
    1d54:	00c10a13          	addi	s4,sp,12
    1d58:	10058863          	beqz	a1,1e68 <core_bench_state+0x1a8>
    1d5c:	00098593          	mv	a1,s3
    1d60:	000a0513          	mv	a0,s4
    1d64:	c75ff0ef          	jal	19d8 <core_state_transition>
    1d68:	00251713          	slli	a4,a0,0x2
    1d6c:	00870733          	add	a4,a4,s0
    1d70:	00c12683          	lw	a3,12(sp)
    1d74:	00072783          	lw	a5,0(a4)
    1d78:	0006c683          	lbu	a3,0(a3)
    1d7c:	00178793          	addi	a5,a5,1
    1d80:	00f72023          	sw	a5,0(a4)
    1d84:	fc069ce3          	bnez	a3,1d5c <core_bench_state+0x9c>
    1d88:	00912623          	sw	s1,12(sp)
    1d8c:	01848c33          	add	s8,s1,s8
    1d90:	0384f863          	bgeu	s1,s8,1dc0 <core_bench_state+0x100>
    1d94:	00048793          	mv	a5,s1
    1d98:	02c00613          	li	a2,44
    1d9c:	0007c703          	lbu	a4,0(a5)
    1da0:	017746b3          	xor	a3,a4,s7
    1da4:	00c70463          	beq	a4,a2,1dac <core_bench_state+0xec>
    1da8:	00d78023          	sb	a3,0(a5)
    1dac:	015787b3          	add	a5,a5,s5
    1db0:	ff87e6e3          	bltu	a5,s8,1d9c <core_bench_state+0xdc>
    1db4:	0004c783          	lbu	a5,0(s1) # fffff000 <_stack_start+0xffff7000>
    1db8:	00c10a13          	addi	s4,sp,12
    1dbc:	02078863          	beqz	a5,1dec <core_bench_state+0x12c>
    1dc0:	00098593          	mv	a1,s3
    1dc4:	000a0513          	mv	a0,s4
    1dc8:	c11ff0ef          	jal	19d8 <core_state_transition>
    1dcc:	00251713          	slli	a4,a0,0x2
    1dd0:	00870733          	add	a4,a4,s0
    1dd4:	00c12683          	lw	a3,12(sp)
    1dd8:	00072783          	lw	a5,0(a4)
    1ddc:	0006c683          	lbu	a3,0(a3)
    1de0:	00178793          	addi	a5,a5,1
    1de4:	00f72023          	sw	a5,0(a4)
    1de8:	fc069ce3          	bnez	a3,1dc0 <core_bench_state+0x100>
    1dec:	02c00693          	li	a3,44
    1df0:	0184fe63          	bgeu	s1,s8,1e0c <core_bench_state+0x14c>
    1df4:	0004c783          	lbu	a5,0(s1)
    1df8:	0167c733          	xor	a4,a5,s6
    1dfc:	00d78463          	beq	a5,a3,1e04 <core_bench_state+0x144>
    1e00:	00e48023          	sb	a4,0(s1)
    1e04:	015484b3          	add	s1,s1,s5
    1e08:	ff84e6e3          	bltu	s1,s8,1df4 <core_bench_state+0x134>
    1e0c:	00098493          	mv	s1,s3
    1e10:	00042503          	lw	a0,0(s0)
    1e14:	00090593          	mv	a1,s2
    1e18:	00440413          	addi	s0,s0,4
    1e1c:	2e4000ef          	jal	2100 <crcu32>
    1e20:	00050593          	mv	a1,a0
    1e24:	0004a503          	lw	a0,0(s1)
    1e28:	00448493          	addi	s1,s1,4
    1e2c:	2d4000ef          	jal	2100 <crcu32>
    1e30:	00050913          	mv	s2,a0
    1e34:	fc899ee3          	bne	s3,s0,1e10 <core_bench_state+0x150>
    1e38:	07c12083          	lw	ra,124(sp)
    1e3c:	07812403          	lw	s0,120(sp)
    1e40:	07412483          	lw	s1,116(sp)
    1e44:	07012903          	lw	s2,112(sp)
    1e48:	06c12983          	lw	s3,108(sp)
    1e4c:	06812a03          	lw	s4,104(sp)
    1e50:	06412a83          	lw	s5,100(sp)
    1e54:	06012b03          	lw	s6,96(sp)
    1e58:	05c12b83          	lw	s7,92(sp)
    1e5c:	05812c03          	lw	s8,88(sp)
    1e60:	08010113          	addi	sp,sp,128
    1e64:	00008067          	ret
    1e68:	00a48c33          	add	s8,s1,a0
    1e6c:	f384e4e3          	bltu	s1,s8,1d94 <core_bench_state+0xd4>
    1e70:	f9dff06f          	j	1e0c <core_bench_state+0x14c>

00001e74 <get_seed_32>:
    1e74:	00500793          	li	a5,5
    1e78:	04a7ec63          	bltu	a5,a0,1ed0 <get_seed_32+0x5c>
    1e7c:	000047b7          	lui	a5,0x4
    1e80:	d9c78793          	addi	a5,a5,-612 # 3d9c <intpat+0x10>
    1e84:	00251513          	slli	a0,a0,0x2
    1e88:	00f50533          	add	a0,a0,a5
    1e8c:	00052783          	lw	a5,0(a0)
    1e90:	00078067          	jr	a5
    1e94:	000047b7          	lui	a5,0x4
    1e98:	7f47a503          	lw	a0,2036(a5) # 47f4 <seed5_volatile>
    1e9c:	00008067          	ret
    1ea0:	000047b7          	lui	a5,0x4
    1ea4:	7fc7a503          	lw	a0,2044(a5) # 47fc <seed1_volatile>
    1ea8:	00008067          	ret
    1eac:	000047b7          	lui	a5,0x4
    1eb0:	7f87a503          	lw	a0,2040(a5) # 47f8 <seed2_volatile>
    1eb4:	00008067          	ret
    1eb8:	000047b7          	lui	a5,0x4
    1ebc:	0187a503          	lw	a0,24(a5) # 4018 <seed3_volatile>
    1ec0:	00008067          	ret
    1ec4:	000047b7          	lui	a5,0x4
    1ec8:	0147a503          	lw	a0,20(a5) # 4014 <seed4_volatile>
    1ecc:	00008067          	ret
    1ed0:	00000513          	li	a0,0
    1ed4:	00008067          	ret

00001ed8 <crcu16>:
    1ed8:	0ff5f793          	zext.b	a5,a1
    1edc:	00879793          	slli	a5,a5,0x8
    1ee0:	0085d593          	srli	a1,a1,0x8
    1ee4:	00001737          	lui	a4,0x1
    1ee8:	fffff337          	lui	t1,0xfffff
    1eec:	0f030313          	addi	t1,t1,240 # fffff0f0 <_stack_start+0xffff70f0>
    1ef0:	f0f70713          	addi	a4,a4,-241 # f0f <main+0x697>
    1ef4:	00b7e7b3          	or	a5,a5,a1
    1ef8:	00e7f5b3          	and	a1,a5,a4
    1efc:	0067f7b3          	and	a5,a5,t1
    1f00:	0047d793          	srli	a5,a5,0x4
    1f04:	00459593          	slli	a1,a1,0x4
    1f08:	00f5e5b3          	or	a1,a1,a5
    1f0c:	ffffd8b7          	lui	a7,0xffffd
    1f10:	000037b7          	lui	a5,0x3
    1f14:	ccc88893          	addi	a7,a7,-820 # ffffcccc <_stack_start+0xffff4ccc>
    1f18:	33378793          	addi	a5,a5,819 # 3333 <ee_printf+0x89f>
    1f1c:	00f57693          	andi	a3,a0,15
    1f20:	0f057813          	andi	a6,a0,240
    1f24:	00f5f633          	and	a2,a1,a5
    1f28:	00485813          	srli	a6,a6,0x4
    1f2c:	0115f5b3          	and	a1,a1,a7
    1f30:	00469693          	slli	a3,a3,0x4
    1f34:	0106e6b3          	or	a3,a3,a6
    1f38:	0025d593          	srli	a1,a1,0x2
    1f3c:	00261613          	slli	a2,a2,0x2
    1f40:	00b66633          	or	a2,a2,a1
    1f44:	0336fe13          	andi	t3,a3,51
    1f48:	000055b7          	lui	a1,0x5
    1f4c:	0cc6f693          	andi	a3,a3,204
    1f50:	ffffb837          	lui	a6,0xffffb
    1f54:	55558593          	addi	a1,a1,1365 # 5555 <uart_read_buff+0xd55>
    1f58:	aaa80813          	addi	a6,a6,-1366 # ffffaaaa <_stack_start+0xffff2aaa>
    1f5c:	0026de93          	srli	t4,a3,0x2
    1f60:	002e1e13          	slli	t3,t3,0x2
    1f64:	00b676b3          	and	a3,a2,a1
    1f68:	01de6e33          	or	t3,t3,t4
    1f6c:	01067633          	and	a2,a2,a6
    1f70:	00169693          	slli	a3,a3,0x1
    1f74:	00165613          	srli	a2,a2,0x1
    1f78:	055e7f13          	andi	t5,t3,85
    1f7c:	0aae7e13          	andi	t3,t3,170
    1f80:	00c6eeb3          	or	t4,a3,a2
    1f84:	001f1f13          	slli	t5,t5,0x1
    1f88:	001e5e13          	srli	t3,t3,0x1
    1f8c:	01cf6e33          	or	t3,t5,t3
    1f90:	008ede93          	srli	t4,t4,0x8
    1f94:	01ceceb3          	xor	t4,t4,t3
    1f98:	00003e37          	lui	t3,0x3
    1f9c:	604e0e13          	addi	t3,t3,1540 # 3604 <memcpy+0x128>
    1fa0:	00c6e633          	or	a2,a3,a2
    1fa4:	001e9693          	slli	a3,t4,0x1
    1fa8:	01c686b3          	add	a3,a3,t3
    1fac:	0006d683          	lhu	a3,0(a3)
    1fb0:	00861613          	slli	a2,a2,0x8
    1fb4:	00855513          	srli	a0,a0,0x8
    1fb8:	00c6c633          	xor	a2,a3,a2
    1fbc:	01061e93          	slli	t4,a2,0x10
    1fc0:	0ff6f693          	zext.b	a3,a3
    1fc4:	018ed613          	srli	a2,t4,0x18
    1fc8:	00869693          	slli	a3,a3,0x8
    1fcc:	00c6e6b3          	or	a3,a3,a2
    1fd0:	00e6f633          	and	a2,a3,a4
    1fd4:	0066f6b3          	and	a3,a3,t1
    1fd8:	0046d693          	srli	a3,a3,0x4
    1fdc:	00461613          	slli	a2,a2,0x4
    1fe0:	00d66633          	or	a2,a2,a3
    1fe4:	00f676b3          	and	a3,a2,a5
    1fe8:	01167633          	and	a2,a2,a7
    1fec:	00265613          	srli	a2,a2,0x2
    1ff0:	00269693          	slli	a3,a3,0x2
    1ff4:	00c6e6b3          	or	a3,a3,a2
    1ff8:	00b6f633          	and	a2,a3,a1
    1ffc:	0106f6b3          	and	a3,a3,a6
    2000:	00161613          	slli	a2,a2,0x1
    2004:	0016d693          	srli	a3,a3,0x1
    2008:	00d666b3          	or	a3,a2,a3
    200c:	0ff6f613          	zext.b	a2,a3
    2010:	00861613          	slli	a2,a2,0x8
    2014:	0086d693          	srli	a3,a3,0x8
    2018:	00d66633          	or	a2,a2,a3
    201c:	00e676b3          	and	a3,a2,a4
    2020:	00667eb3          	and	t4,a2,t1
    2024:	004ede93          	srli	t4,t4,0x4
    2028:	00f57613          	andi	a2,a0,15
    202c:	00469693          	slli	a3,a3,0x4
    2030:	01d6e6b3          	or	a3,a3,t4
    2034:	00455513          	srli	a0,a0,0x4
    2038:	00461613          	slli	a2,a2,0x4
    203c:	00a66633          	or	a2,a2,a0
    2040:	0116feb3          	and	t4,a3,a7
    2044:	00f6f533          	and	a0,a3,a5
    2048:	002ede93          	srli	t4,t4,0x2
    204c:	03367693          	andi	a3,a2,51
    2050:	00251513          	slli	a0,a0,0x2
    2054:	0cc67613          	andi	a2,a2,204
    2058:	01d56533          	or	a0,a0,t4
    205c:	00265613          	srli	a2,a2,0x2
    2060:	00269693          	slli	a3,a3,0x2
    2064:	00c6e6b3          	or	a3,a3,a2
    2068:	00b57633          	and	a2,a0,a1
    206c:	01057533          	and	a0,a0,a6
    2070:	0556ff13          	andi	t5,a3,85
    2074:	00161613          	slli	a2,a2,0x1
    2078:	00155513          	srli	a0,a0,0x1
    207c:	0aa6f693          	andi	a3,a3,170
    2080:	00a66eb3          	or	t4,a2,a0
    2084:	0016d693          	srli	a3,a3,0x1
    2088:	001f1f13          	slli	t5,t5,0x1
    208c:	00df6f33          	or	t5,t5,a3
    2090:	008ed693          	srli	a3,t4,0x8
    2094:	01e6c6b3          	xor	a3,a3,t5
    2098:	00169693          	slli	a3,a3,0x1
    209c:	01c686b3          	add	a3,a3,t3
    20a0:	0006d683          	lhu	a3,0(a3)
    20a4:	008e9613          	slli	a2,t4,0x8
    20a8:	00c6c633          	xor	a2,a3,a2
    20ac:	01061513          	slli	a0,a2,0x10
    20b0:	0ff6f693          	zext.b	a3,a3
    20b4:	01855613          	srli	a2,a0,0x18
    20b8:	00869693          	slli	a3,a3,0x8
    20bc:	00c6e6b3          	or	a3,a3,a2
    20c0:	00e6f733          	and	a4,a3,a4
    20c4:	0066f6b3          	and	a3,a3,t1
    20c8:	0046d693          	srli	a3,a3,0x4
    20cc:	00471713          	slli	a4,a4,0x4
    20d0:	00d76733          	or	a4,a4,a3
    20d4:	00f777b3          	and	a5,a4,a5
    20d8:	01177733          	and	a4,a4,a7
    20dc:	00275713          	srli	a4,a4,0x2
    20e0:	00279793          	slli	a5,a5,0x2
    20e4:	00e7e7b3          	or	a5,a5,a4
    20e8:	00b7f533          	and	a0,a5,a1
    20ec:	0107f7b3          	and	a5,a5,a6
    20f0:	0017d793          	srli	a5,a5,0x1
    20f4:	00151513          	slli	a0,a0,0x1
    20f8:	00f56533          	or	a0,a0,a5
    20fc:	00008067          	ret

00002100 <crcu32>:
    2100:	0ff5f793          	zext.b	a5,a1
    2104:	00879793          	slli	a5,a5,0x8
    2108:	0085d593          	srli	a1,a1,0x8
    210c:	00001737          	lui	a4,0x1
    2110:	fffff8b7          	lui	a7,0xfffff
    2114:	0f088893          	addi	a7,a7,240 # fffff0f0 <_stack_start+0xffff70f0>
    2118:	f0f70713          	addi	a4,a4,-241 # f0f <main+0x697>
    211c:	00b7e7b3          	or	a5,a5,a1
    2120:	00e7f6b3          	and	a3,a5,a4
    2124:	0117f7b3          	and	a5,a5,a7
    2128:	0047d793          	srli	a5,a5,0x4
    212c:	00469693          	slli	a3,a3,0x4
    2130:	00f6e6b3          	or	a3,a3,a5
    2134:	ffffd837          	lui	a6,0xffffd
    2138:	000037b7          	lui	a5,0x3
    213c:	ccc80813          	addi	a6,a6,-820 # ffffcccc <_stack_start+0xffff4ccc>
    2140:	33378793          	addi	a5,a5,819 # 3333 <ee_printf+0x89f>
    2144:	00f57613          	andi	a2,a0,15
    2148:	0f057593          	andi	a1,a0,240
    214c:	00f6f333          	and	t1,a3,a5
    2150:	0045d593          	srli	a1,a1,0x4
    2154:	0106f6b3          	and	a3,a3,a6
    2158:	00461613          	slli	a2,a2,0x4
    215c:	00b66633          	or	a2,a2,a1
    2160:	0026d693          	srli	a3,a3,0x2
    2164:	00231313          	slli	t1,t1,0x2
    2168:	00d36333          	or	t1,t1,a3
    216c:	03367e13          	andi	t3,a2,51
    2170:	000056b7          	lui	a3,0x5
    2174:	0cc67613          	andi	a2,a2,204
    2178:	ffffb5b7          	lui	a1,0xffffb
    217c:	55568693          	addi	a3,a3,1365 # 5555 <uart_read_buff+0xd55>
    2180:	aaa58593          	addi	a1,a1,-1366 # ffffaaaa <_stack_start+0xffff2aaa>
    2184:	00265e93          	srli	t4,a2,0x2
    2188:	002e1e13          	slli	t3,t3,0x2
    218c:	00d37633          	and	a2,t1,a3
    2190:	01de6e33          	or	t3,t3,t4
    2194:	00b37333          	and	t1,t1,a1
    2198:	00161613          	slli	a2,a2,0x1
    219c:	00135313          	srli	t1,t1,0x1
    21a0:	055e7f13          	andi	t5,t3,85
    21a4:	0aae7e13          	andi	t3,t3,170
    21a8:	00666eb3          	or	t4,a2,t1
    21ac:	001f1f13          	slli	t5,t5,0x1
    21b0:	001e5e13          	srli	t3,t3,0x1
    21b4:	01cf6e33          	or	t3,t5,t3
    21b8:	008ede93          	srli	t4,t4,0x8
    21bc:	01ceceb3          	xor	t4,t4,t3
    21c0:	00666e33          	or	t3,a2,t1
    21c4:	00003337          	lui	t1,0x3
    21c8:	60430313          	addi	t1,t1,1540 # 3604 <memcpy+0x128>
    21cc:	001e9613          	slli	a2,t4,0x1
    21d0:	00660633          	add	a2,a2,t1
    21d4:	00065603          	lhu	a2,0(a2)
    21d8:	008e1e13          	slli	t3,t3,0x8
    21dc:	00855f13          	srli	t5,a0,0x8
    21e0:	01c64e33          	xor	t3,a2,t3
    21e4:	010e1e93          	slli	t4,t3,0x10
    21e8:	0ff67613          	zext.b	a2,a2
    21ec:	018ede13          	srli	t3,t4,0x18
    21f0:	00861613          	slli	a2,a2,0x8
    21f4:	01c66633          	or	a2,a2,t3
    21f8:	00e67e33          	and	t3,a2,a4
    21fc:	01167633          	and	a2,a2,a7
    2200:	00465613          	srli	a2,a2,0x4
    2204:	004e1e13          	slli	t3,t3,0x4
    2208:	00ce6e33          	or	t3,t3,a2
    220c:	00fe7633          	and	a2,t3,a5
    2210:	010e7e33          	and	t3,t3,a6
    2214:	002e5e13          	srli	t3,t3,0x2
    2218:	00261613          	slli	a2,a2,0x2
    221c:	01c66633          	or	a2,a2,t3
    2220:	00d67e33          	and	t3,a2,a3
    2224:	00b67633          	and	a2,a2,a1
    2228:	00165613          	srli	a2,a2,0x1
    222c:	001e1e13          	slli	t3,t3,0x1
    2230:	00ce6e33          	or	t3,t3,a2
    2234:	0ffe7613          	zext.b	a2,t3
    2238:	00861613          	slli	a2,a2,0x8
    223c:	008e5e13          	srli	t3,t3,0x8
    2240:	01c66633          	or	a2,a2,t3
    2244:	00e67eb3          	and	t4,a2,a4
    2248:	01167633          	and	a2,a2,a7
    224c:	00465613          	srli	a2,a2,0x4
    2250:	004e9e93          	slli	t4,t4,0x4
    2254:	00ceeeb3          	or	t4,t4,a2
    2258:	00ff7613          	andi	a2,t5,15
    225c:	0f0f7f13          	andi	t5,t5,240
    2260:	00fefe33          	and	t3,t4,a5
    2264:	004f5f13          	srli	t5,t5,0x4
    2268:	010efeb3          	and	t4,t4,a6
    226c:	00461613          	slli	a2,a2,0x4
    2270:	01e66633          	or	a2,a2,t5
    2274:	002ede93          	srli	t4,t4,0x2
    2278:	002e1e13          	slli	t3,t3,0x2
    227c:	01de6e33          	or	t3,t3,t4
    2280:	03367e93          	andi	t4,a2,51
    2284:	0cc67613          	andi	a2,a2,204
    2288:	00265f13          	srli	t5,a2,0x2
    228c:	002e9e93          	slli	t4,t4,0x2
    2290:	00de7633          	and	a2,t3,a3
    2294:	01eeeeb3          	or	t4,t4,t5
    2298:	00be7e33          	and	t3,t3,a1
    229c:	00161613          	slli	a2,a2,0x1
    22a0:	001e5e13          	srli	t3,t3,0x1
    22a4:	055eff93          	andi	t6,t4,85
    22a8:	0aaefe93          	andi	t4,t4,170
    22ac:	01c66f33          	or	t5,a2,t3
    22b0:	001f9f93          	slli	t6,t6,0x1
    22b4:	001ede93          	srli	t4,t4,0x1
    22b8:	008f5f13          	srli	t5,t5,0x8
    22bc:	01dfeeb3          	or	t4,t6,t4
    22c0:	01df4eb3          	xor	t4,t5,t4
    22c4:	01c66e33          	or	t3,a2,t3
    22c8:	001e9613          	slli	a2,t4,0x1
    22cc:	00660633          	add	a2,a2,t1
    22d0:	00065603          	lhu	a2,0(a2)
    22d4:	008e1e13          	slli	t3,t3,0x8
    22d8:	01055e93          	srli	t4,a0,0x10
    22dc:	01c64e33          	xor	t3,a2,t3
    22e0:	010e1f13          	slli	t5,t3,0x10
    22e4:	0ff67613          	zext.b	a2,a2
    22e8:	018f5e13          	srli	t3,t5,0x18
    22ec:	00861613          	slli	a2,a2,0x8
    22f0:	01c66633          	or	a2,a2,t3
    22f4:	00e67e33          	and	t3,a2,a4
    22f8:	01167633          	and	a2,a2,a7
    22fc:	00465613          	srli	a2,a2,0x4
    2300:	004e1e13          	slli	t3,t3,0x4
    2304:	00ce6e33          	or	t3,t3,a2
    2308:	00fe7633          	and	a2,t3,a5
    230c:	010e7e33          	and	t3,t3,a6
    2310:	002e5e13          	srli	t3,t3,0x2
    2314:	00261613          	slli	a2,a2,0x2
    2318:	01c66633          	or	a2,a2,t3
    231c:	00d67e33          	and	t3,a2,a3
    2320:	00b67633          	and	a2,a2,a1
    2324:	001e1e13          	slli	t3,t3,0x1
    2328:	00165613          	srli	a2,a2,0x1
    232c:	00ce6633          	or	a2,t3,a2
    2330:	0ff67e13          	zext.b	t3,a2
    2334:	008e1e13          	slli	t3,t3,0x8
    2338:	00865613          	srli	a2,a2,0x8
    233c:	00ce6e33          	or	t3,t3,a2
    2340:	00ee7633          	and	a2,t3,a4
    2344:	011e7e33          	and	t3,t3,a7
    2348:	004e5e13          	srli	t3,t3,0x4
    234c:	00461613          	slli	a2,a2,0x4
    2350:	01c66633          	or	a2,a2,t3
    2354:	00fefe13          	andi	t3,t4,15
    2358:	0f0efe93          	andi	t4,t4,240
    235c:	004edf13          	srli	t5,t4,0x4
    2360:	004e1e13          	slli	t3,t3,0x4
    2364:	00f67eb3          	and	t4,a2,a5
    2368:	01067633          	and	a2,a2,a6
    236c:	01ee6e33          	or	t3,t3,t5
    2370:	00265613          	srli	a2,a2,0x2
    2374:	002e9e93          	slli	t4,t4,0x2
    2378:	00ceeeb3          	or	t4,t4,a2
    237c:	033e7613          	andi	a2,t3,51
    2380:	0cce7e13          	andi	t3,t3,204
    2384:	002e5f13          	srli	t5,t3,0x2
    2388:	00261613          	slli	a2,a2,0x2
    238c:	00defe33          	and	t3,t4,a3
    2390:	01e66633          	or	a2,a2,t5
    2394:	00befeb3          	and	t4,t4,a1
    2398:	001ede93          	srli	t4,t4,0x1
    239c:	001e1e13          	slli	t3,t3,0x1
    23a0:	05567f93          	andi	t6,a2,85
    23a4:	0aa67613          	andi	a2,a2,170
    23a8:	01de6f33          	or	t5,t3,t4
    23ac:	001f9f93          	slli	t6,t6,0x1
    23b0:	00165613          	srli	a2,a2,0x1
    23b4:	008f5f13          	srli	t5,t5,0x8
    23b8:	00cfe633          	or	a2,t6,a2
    23bc:	00cf4633          	xor	a2,t5,a2
    23c0:	00161613          	slli	a2,a2,0x1
    23c4:	00660633          	add	a2,a2,t1
    23c8:	00065603          	lhu	a2,0(a2)
    23cc:	01de6e33          	or	t3,t3,t4
    23d0:	008e1e13          	slli	t3,t3,0x8
    23d4:	01c64e33          	xor	t3,a2,t3
    23d8:	010e1e93          	slli	t4,t3,0x10
    23dc:	0ff67613          	zext.b	a2,a2
    23e0:	018ede13          	srli	t3,t4,0x18
    23e4:	00861613          	slli	a2,a2,0x8
    23e8:	01c66633          	or	a2,a2,t3
    23ec:	00e67e33          	and	t3,a2,a4
    23f0:	01167633          	and	a2,a2,a7
    23f4:	00465613          	srli	a2,a2,0x4
    23f8:	004e1e13          	slli	t3,t3,0x4
    23fc:	00ce6e33          	or	t3,t3,a2
    2400:	00fe7633          	and	a2,t3,a5
    2404:	010e7e33          	and	t3,t3,a6
    2408:	002e5e13          	srli	t3,t3,0x2
    240c:	00261613          	slli	a2,a2,0x2
    2410:	01c66633          	or	a2,a2,t3
    2414:	00d67e33          	and	t3,a2,a3
    2418:	00b67633          	and	a2,a2,a1
    241c:	00165613          	srli	a2,a2,0x1
    2420:	001e1e13          	slli	t3,t3,0x1
    2424:	00ce6e33          	or	t3,t3,a2
    2428:	0ffe7613          	zext.b	a2,t3
    242c:	00861613          	slli	a2,a2,0x8
    2430:	008e5e13          	srli	t3,t3,0x8
    2434:	01c66633          	or	a2,a2,t3
    2438:	00e67eb3          	and	t4,a2,a4
    243c:	01167e33          	and	t3,a2,a7
    2440:	01855513          	srli	a0,a0,0x18
    2444:	00f57613          	andi	a2,a0,15
    2448:	004e5e13          	srli	t3,t3,0x4
    244c:	004e9e93          	slli	t4,t4,0x4
    2450:	00461613          	slli	a2,a2,0x4
    2454:	01ceeeb3          	or	t4,t4,t3
    2458:	00455513          	srli	a0,a0,0x4
    245c:	00fefe33          	and	t3,t4,a5
    2460:	00a66533          	or	a0,a2,a0
    2464:	010efeb3          	and	t4,t4,a6
    2468:	03357613          	andi	a2,a0,51
    246c:	002ede93          	srli	t4,t4,0x2
    2470:	0cc57513          	andi	a0,a0,204
    2474:	002e1e13          	slli	t3,t3,0x2
    2478:	01de6e33          	or	t3,t3,t4
    247c:	00255513          	srli	a0,a0,0x2
    2480:	00261613          	slli	a2,a2,0x2
    2484:	00a66633          	or	a2,a2,a0
    2488:	00de7533          	and	a0,t3,a3
    248c:	00be7e33          	and	t3,t3,a1
    2490:	05567f13          	andi	t5,a2,85
    2494:	00151513          	slli	a0,a0,0x1
    2498:	001e5e13          	srli	t3,t3,0x1
    249c:	0aa67613          	andi	a2,a2,170
    24a0:	01c56eb3          	or	t4,a0,t3
    24a4:	00165613          	srli	a2,a2,0x1
    24a8:	001f1f13          	slli	t5,t5,0x1
    24ac:	00cf6f33          	or	t5,t5,a2
    24b0:	008ed613          	srli	a2,t4,0x8
    24b4:	01e64633          	xor	a2,a2,t5
    24b8:	00161613          	slli	a2,a2,0x1
    24bc:	00660633          	add	a2,a2,t1
    24c0:	00065603          	lhu	a2,0(a2)
    24c4:	008e9513          	slli	a0,t4,0x8
    24c8:	00a64533          	xor	a0,a2,a0
    24cc:	01051313          	slli	t1,a0,0x10
    24d0:	0ff67613          	zext.b	a2,a2
    24d4:	01835513          	srli	a0,t1,0x18
    24d8:	00861613          	slli	a2,a2,0x8
    24dc:	00a66633          	or	a2,a2,a0
    24e0:	00e67733          	and	a4,a2,a4
    24e4:	01167633          	and	a2,a2,a7
    24e8:	00465613          	srli	a2,a2,0x4
    24ec:	00471713          	slli	a4,a4,0x4
    24f0:	00c76733          	or	a4,a4,a2
    24f4:	00f777b3          	and	a5,a4,a5
    24f8:	01077733          	and	a4,a4,a6
    24fc:	00275713          	srli	a4,a4,0x2
    2500:	00279793          	slli	a5,a5,0x2
    2504:	00e7e7b3          	or	a5,a5,a4
    2508:	00d7f533          	and	a0,a5,a3
    250c:	00b7f7b3          	and	a5,a5,a1
    2510:	0017d793          	srli	a5,a5,0x1
    2514:	00151513          	slli	a0,a0,0x1
    2518:	00f56533          	or	a0,a0,a5
    251c:	00008067          	ret

00002520 <crc16>:
    2520:	0ff5f793          	zext.b	a5,a1
    2524:	00879793          	slli	a5,a5,0x8
    2528:	0085d593          	srli	a1,a1,0x8
    252c:	00001737          	lui	a4,0x1
    2530:	fffff337          	lui	t1,0xfffff
    2534:	0f030313          	addi	t1,t1,240 # fffff0f0 <_stack_start+0xffff70f0>
    2538:	f0f70713          	addi	a4,a4,-241 # f0f <main+0x697>
    253c:	00b7e7b3          	or	a5,a5,a1
    2540:	00e7f5b3          	and	a1,a5,a4
    2544:	0067f7b3          	and	a5,a5,t1
    2548:	0047d793          	srli	a5,a5,0x4
    254c:	00459593          	slli	a1,a1,0x4
    2550:	00f5e5b3          	or	a1,a1,a5
    2554:	ffffd8b7          	lui	a7,0xffffd
    2558:	000037b7          	lui	a5,0x3
    255c:	ccc88893          	addi	a7,a7,-820 # ffffcccc <_stack_start+0xffff4ccc>
    2560:	33378793          	addi	a5,a5,819 # 3333 <ee_printf+0x89f>
    2564:	00f57693          	andi	a3,a0,15
    2568:	0f057813          	andi	a6,a0,240
    256c:	00f5f633          	and	a2,a1,a5
    2570:	00485813          	srli	a6,a6,0x4
    2574:	0115f5b3          	and	a1,a1,a7
    2578:	00469693          	slli	a3,a3,0x4
    257c:	0106e6b3          	or	a3,a3,a6
    2580:	0025d593          	srli	a1,a1,0x2
    2584:	00261613          	slli	a2,a2,0x2
    2588:	00b66633          	or	a2,a2,a1
    258c:	0336fe13          	andi	t3,a3,51
    2590:	000055b7          	lui	a1,0x5
    2594:	0cc6f693          	andi	a3,a3,204
    2598:	ffffb837          	lui	a6,0xffffb
    259c:	55558593          	addi	a1,a1,1365 # 5555 <uart_read_buff+0xd55>
    25a0:	aaa80813          	addi	a6,a6,-1366 # ffffaaaa <_stack_start+0xffff2aaa>
    25a4:	0026de93          	srli	t4,a3,0x2
    25a8:	002e1e13          	slli	t3,t3,0x2
    25ac:	00b676b3          	and	a3,a2,a1
    25b0:	01de6e33          	or	t3,t3,t4
    25b4:	01067633          	and	a2,a2,a6
    25b8:	00169693          	slli	a3,a3,0x1
    25bc:	00165613          	srli	a2,a2,0x1
    25c0:	055e7f13          	andi	t5,t3,85
    25c4:	0aae7e13          	andi	t3,t3,170
    25c8:	00c6eeb3          	or	t4,a3,a2
    25cc:	001f1f13          	slli	t5,t5,0x1
    25d0:	001e5e13          	srli	t3,t3,0x1
    25d4:	01cf6e33          	or	t3,t5,t3
    25d8:	008ede93          	srli	t4,t4,0x8
    25dc:	01ceceb3          	xor	t4,t4,t3
    25e0:	00003e37          	lui	t3,0x3
    25e4:	604e0e13          	addi	t3,t3,1540 # 3604 <memcpy+0x128>
    25e8:	00c6e633          	or	a2,a3,a2
    25ec:	001e9693          	slli	a3,t4,0x1
    25f0:	01c686b3          	add	a3,a3,t3
    25f4:	0006d683          	lhu	a3,0(a3)
    25f8:	00861613          	slli	a2,a2,0x8
    25fc:	00855513          	srli	a0,a0,0x8
    2600:	00c6c633          	xor	a2,a3,a2
    2604:	01061e93          	slli	t4,a2,0x10
    2608:	0ff6f693          	zext.b	a3,a3
    260c:	018ed613          	srli	a2,t4,0x18
    2610:	00869693          	slli	a3,a3,0x8
    2614:	00c6e6b3          	or	a3,a3,a2
    2618:	00e6f633          	and	a2,a3,a4
    261c:	0066f6b3          	and	a3,a3,t1
    2620:	0046d693          	srli	a3,a3,0x4
    2624:	00461613          	slli	a2,a2,0x4
    2628:	00d66633          	or	a2,a2,a3
    262c:	00f676b3          	and	a3,a2,a5
    2630:	01167633          	and	a2,a2,a7
    2634:	00265613          	srli	a2,a2,0x2
    2638:	00269693          	slli	a3,a3,0x2
    263c:	00c6e6b3          	or	a3,a3,a2
    2640:	00b6f633          	and	a2,a3,a1
    2644:	0106f6b3          	and	a3,a3,a6
    2648:	00161613          	slli	a2,a2,0x1
    264c:	0016d693          	srli	a3,a3,0x1
    2650:	00d666b3          	or	a3,a2,a3
    2654:	0ff6f613          	zext.b	a2,a3
    2658:	00861613          	slli	a2,a2,0x8
    265c:	0086d693          	srli	a3,a3,0x8
    2660:	00d66633          	or	a2,a2,a3
    2664:	00e676b3          	and	a3,a2,a4
    2668:	00667eb3          	and	t4,a2,t1
    266c:	004ede93          	srli	t4,t4,0x4
    2670:	00f57613          	andi	a2,a0,15
    2674:	00469693          	slli	a3,a3,0x4
    2678:	0f057513          	andi	a0,a0,240
    267c:	01d6e6b3          	or	a3,a3,t4
    2680:	00455513          	srli	a0,a0,0x4
    2684:	00461613          	slli	a2,a2,0x4
    2688:	00a66633          	or	a2,a2,a0
    268c:	0116feb3          	and	t4,a3,a7
    2690:	00f6f533          	and	a0,a3,a5
    2694:	002ede93          	srli	t4,t4,0x2
    2698:	03367693          	andi	a3,a2,51
    269c:	00251513          	slli	a0,a0,0x2
    26a0:	0cc67613          	andi	a2,a2,204
    26a4:	01d56533          	or	a0,a0,t4
    26a8:	00265613          	srli	a2,a2,0x2
    26ac:	00269693          	slli	a3,a3,0x2
    26b0:	00c6e6b3          	or	a3,a3,a2
    26b4:	00b57633          	and	a2,a0,a1
    26b8:	01057533          	and	a0,a0,a6
    26bc:	0556ff13          	andi	t5,a3,85
    26c0:	00161613          	slli	a2,a2,0x1
    26c4:	00155513          	srli	a0,a0,0x1
    26c8:	0aa6f693          	andi	a3,a3,170
    26cc:	00a66eb3          	or	t4,a2,a0
    26d0:	0016d693          	srli	a3,a3,0x1
    26d4:	001f1f13          	slli	t5,t5,0x1
    26d8:	00df6f33          	or	t5,t5,a3
    26dc:	008ed693          	srli	a3,t4,0x8
    26e0:	01e6c6b3          	xor	a3,a3,t5
    26e4:	00169693          	slli	a3,a3,0x1
    26e8:	01c686b3          	add	a3,a3,t3
    26ec:	0006d683          	lhu	a3,0(a3)
    26f0:	008e9613          	slli	a2,t4,0x8
    26f4:	00c6c633          	xor	a2,a3,a2
    26f8:	01061513          	slli	a0,a2,0x10
    26fc:	0ff6f693          	zext.b	a3,a3
    2700:	01855613          	srli	a2,a0,0x18
    2704:	00869693          	slli	a3,a3,0x8
    2708:	00c6e6b3          	or	a3,a3,a2
    270c:	00e6f733          	and	a4,a3,a4
    2710:	0066f6b3          	and	a3,a3,t1
    2714:	0046d693          	srli	a3,a3,0x4
    2718:	00471713          	slli	a4,a4,0x4
    271c:	00d76733          	or	a4,a4,a3
    2720:	00f777b3          	and	a5,a4,a5
    2724:	01177733          	and	a4,a4,a7
    2728:	00275713          	srli	a4,a4,0x2
    272c:	00279793          	slli	a5,a5,0x2
    2730:	00e7e7b3          	or	a5,a5,a4
    2734:	00b7f533          	and	a0,a5,a1
    2738:	0107f7b3          	and	a5,a5,a6
    273c:	0017d793          	srli	a5,a5,0x1
    2740:	00151513          	slli	a0,a0,0x1
    2744:	00f56533          	or	a0,a0,a5
    2748:	00008067          	ret

0000274c <check_data_types>:
    274c:	00000513          	li	a0,0
    2750:	00008067          	ret

00002754 <number>:
    2754:	f8010113          	addi	sp,sp,-128
    2758:	06112e23          	sw	ra,124(sp)
    275c:	06812c23          	sw	s0,120(sp)
    2760:	06912a23          	sw	s1,116(sp)
    2764:	07212823          	sw	s2,112(sp)
    2768:	0407fe13          	andi	t3,a5,64
    276c:	00050893          	mv	a7,a0
    2770:	00060313          	mv	t1,a2
    2774:	180e1663          	bnez	t3,2900 <number+0x1ac>
    2778:	00004637          	lui	a2,0x4
    277c:	0107ff93          	andi	t6,a5,16
    2780:	db460613          	addi	a2,a2,-588 # 3db4 <intpat+0x28>
    2784:	180f9663          	bnez	t6,2910 <number+0x1bc>
    2788:	0017f293          	andi	t0,a5,1
    278c:	fff28e93          	addi	t4,t0,-1
    2790:	ff0efe93          	andi	t4,t4,-16
    2794:	0027f513          	andi	a0,a5,2
    2798:	030e8e93          	addi	t4,t4,48
    279c:	0207ff13          	andi	t5,a5,32
    27a0:	18050463          	beqz	a0,2928 <number+0x1d4>
    27a4:	2605c663          	bltz	a1,2a10 <number+0x2bc>
    27a8:	0047f513          	andi	a0,a5,4
    27ac:	22051e63          	bnez	a0,29e8 <number+0x294>
    27b0:	0087f793          	andi	a5,a5,8
    27b4:	00000393          	li	t2,0
    27b8:	00078663          	beqz	a5,27c4 <number+0x70>
    27bc:	fff68693          	addi	a3,a3,-1
    27c0:	02000393          	li	t2,32
    27c4:	000f0e63          	beqz	t5,27e0 <number+0x8c>
    27c8:	01000793          	li	a5,16
    27cc:	26f30663          	beq	t1,a5,2a38 <number+0x2e4>
    27d0:	ff830793          	addi	a5,t1,-8
    27d4:	0017b793          	seqz	a5,a5
    27d8:	40f686b3          	sub	a3,a3,a5
    27dc:	02000f13          	li	t5,32
    27e0:	1a059c63          	bnez	a1,2998 <number+0x244>
    27e4:	03000793          	li	a5,48
    27e8:	02f10623          	sb	a5,44(sp)
    27ec:	00000913          	li	s2,0
    27f0:	00100793          	li	a5,1
    27f4:	02c10413          	addi	s0,sp,44
    27f8:	00078e13          	mv	t3,a5
    27fc:	00e7d463          	bge	a5,a4,2804 <number+0xb0>
    2800:	00070e13          	mv	t3,a4
    2804:	41c684b3          	sub	s1,a3,t3
    2808:	12029663          	bnez	t0,2934 <number+0x1e0>
    280c:	12905263          	blez	s1,2930 <number+0x1dc>
    2810:	00088513          	mv	a0,a7
    2814:	00048613          	mv	a2,s1
    2818:	02000593          	li	a1,32
    281c:	00e12e23          	sw	a4,28(sp)
    2820:	00612c23          	sw	t1,24(sp)
    2824:	00712a23          	sw	t2,20(sp)
    2828:	01e12823          	sw	t5,16(sp)
    282c:	01c12623          	sw	t3,12(sp)
    2830:	00f12423          	sw	a5,8(sp)
    2834:	01d12223          	sw	t4,4(sp)
    2838:	01f12023          	sw	t6,0(sp)
    283c:	3c5000ef          	jal	3400 <memset>
    2840:	01412383          	lw	t2,20(sp)
    2844:	00012f83          	lw	t6,0(sp)
    2848:	00412e83          	lw	t4,4(sp)
    284c:	00812783          	lw	a5,8(sp)
    2850:	00c12e03          	lw	t3,12(sp)
    2854:	01012f03          	lw	t5,16(sp)
    2858:	01812303          	lw	t1,24(sp)
    285c:	01c12703          	lw	a4,28(sp)
    2860:	009508b3          	add	a7,a0,s1
    2864:	16039463          	bnez	t2,29cc <number+0x278>
    2868:	000f0a63          	beqz	t5,287c <number+0x128>
    286c:	00800693          	li	a3,8
    2870:	1ed30e63          	beq	t1,a3,2a6c <number+0x318>
    2874:	01000693          	li	a3,16
    2878:	16d30e63          	beq	t1,a3,29f4 <number+0x2a0>
    287c:	01f034b3          	snez	s1,t6
    2880:	ffe48493          	addi	s1,s1,-2
    2884:	02e7d063          	bge	a5,a4,28a4 <number+0x150>
    2888:	40fe0633          	sub	a2,t3,a5
    288c:	00088513          	mv	a0,a7
    2890:	03000593          	li	a1,48
    2894:	00c12023          	sw	a2,0(sp)
    2898:	369000ef          	jal	3400 <memset>
    289c:	00012603          	lw	a2,0(sp)
    28a0:	00c508b3          	add	a7,a0,a2
    28a4:	012407b3          	add	a5,s0,s2
    28a8:	fff40593          	addi	a1,s0,-1
    28ac:	00088713          	mv	a4,a7
    28b0:	0007c603          	lbu	a2,0(a5)
    28b4:	fff78793          	addi	a5,a5,-1
    28b8:	00170713          	addi	a4,a4,1
    28bc:	fec70fa3          	sb	a2,-1(a4)
    28c0:	fef598e3          	bne	a1,a5,28b0 <number+0x15c>
    28c4:	00190793          	addi	a5,s2,1
    28c8:	00f88833          	add	a6,a7,a5
    28cc:	00905c63          	blez	s1,28e4 <number+0x190>
    28d0:	00080513          	mv	a0,a6
    28d4:	00048613          	mv	a2,s1
    28d8:	02000593          	li	a1,32
    28dc:	325000ef          	jal	3400 <memset>
    28e0:	00950833          	add	a6,a0,s1
    28e4:	07c12083          	lw	ra,124(sp)
    28e8:	07812403          	lw	s0,120(sp)
    28ec:	07412483          	lw	s1,116(sp)
    28f0:	07012903          	lw	s2,112(sp)
    28f4:	00080513          	mv	a0,a6
    28f8:	08010113          	addi	sp,sp,128
    28fc:	00008067          	ret
    2900:	00004637          	lui	a2,0x4
    2904:	0107ff93          	andi	t6,a5,16
    2908:	ddc60613          	addi	a2,a2,-548 # 3ddc <intpat+0x50>
    290c:	e60f8ee3          	beqz	t6,2788 <number+0x34>
    2910:	ffe7f793          	andi	a5,a5,-2
    2914:	0027f513          	andi	a0,a5,2
    2918:	01000293          	li	t0,16
    291c:	02000e93          	li	t4,32
    2920:	0207ff13          	andi	t5,a5,32
    2924:	e80510e3          	bnez	a0,27a4 <number+0x50>
    2928:	00000393          	li	t2,0
    292c:	e99ff06f          	j	27c4 <number+0x70>
    2930:	fff48493          	addi	s1,s1,-1
    2934:	00038663          	beqz	t2,2940 <number+0x1ec>
    2938:	00788023          	sb	t2,0(a7)
    293c:	00188893          	addi	a7,a7,1
    2940:	000f0a63          	beqz	t5,2954 <number+0x200>
    2944:	00800693          	li	a3,8
    2948:	0ed30e63          	beq	t1,a3,2a44 <number+0x2f0>
    294c:	01000693          	li	a3,16
    2950:	0ad30463          	beq	t1,a3,29f8 <number+0x2a4>
    2954:	f20f98e3          	bnez	t6,2884 <number+0x130>
    2958:	12905a63          	blez	s1,2a8c <number+0x338>
    295c:	00048613          	mv	a2,s1
    2960:	00088513          	mv	a0,a7
    2964:	000e8593          	mv	a1,t4
    2968:	00e12423          	sw	a4,8(sp)
    296c:	01c12223          	sw	t3,4(sp)
    2970:	00f12023          	sw	a5,0(sp)
    2974:	28d000ef          	jal	3400 <memset>
    2978:	009508b3          	add	a7,a0,s1
    297c:	00012783          	lw	a5,0(sp)
    2980:	00412e03          	lw	t3,4(sp)
    2984:	00812703          	lw	a4,8(sp)
    2988:	fff00493          	li	s1,-1
    298c:	ef9ff06f          	j	2884 <number+0x130>
    2990:	fff68693          	addi	a3,a3,-1
    2994:	02d00393          	li	t2,45
    2998:	00000793          	li	a5,0
    299c:	02c10413          	addi	s0,sp,44
    29a0:	0265f833          	remu	a6,a1,t1
    29a4:	00078913          	mv	s2,a5
    29a8:	00178793          	addi	a5,a5,1
    29ac:	00f40e33          	add	t3,s0,a5
    29b0:	00058513          	mv	a0,a1
    29b4:	01060833          	add	a6,a2,a6
    29b8:	00084803          	lbu	a6,0(a6)
    29bc:	0265d5b3          	divu	a1,a1,t1
    29c0:	ff0e0fa3          	sb	a6,-1(t3)
    29c4:	fc657ee3          	bgeu	a0,t1,29a0 <number+0x24c>
    29c8:	e31ff06f          	j	27f8 <number+0xa4>
    29cc:	00788023          	sb	t2,0(a7)
    29d0:	00188893          	addi	a7,a7,1
    29d4:	080f1063          	bnez	t5,2a54 <number+0x300>
    29d8:	ffe00493          	li	s1,-2
    29dc:	ea0f84e3          	beqz	t6,2884 <number+0x130>
    29e0:	fff00493          	li	s1,-1
    29e4:	ea1ff06f          	j	2884 <number+0x130>
    29e8:	fff68693          	addi	a3,a3,-1
    29ec:	02b00393          	li	t2,43
    29f0:	dd5ff06f          	j	27c4 <number+0x70>
    29f4:	fff00493          	li	s1,-1
    29f8:	03000613          	li	a2,48
    29fc:	07800693          	li	a3,120
    2a00:	00c88023          	sb	a2,0(a7)
    2a04:	00d880a3          	sb	a3,1(a7)
    2a08:	00288893          	addi	a7,a7,2
    2a0c:	f49ff06f          	j	2954 <number+0x200>
    2a10:	40b005b3          	neg	a1,a1
    2a14:	f60f0ee3          	beqz	t5,2990 <number+0x23c>
    2a18:	01000793          	li	a5,16
    2a1c:	06f30063          	beq	t1,a5,2a7c <number+0x328>
    2a20:	00800793          	li	a5,8
    2a24:	02f30c63          	beq	t1,a5,2a5c <number+0x308>
    2a28:	fff68693          	addi	a3,a3,-1
    2a2c:	02d00393          	li	t2,45
    2a30:	02000f13          	li	t5,32
    2a34:	f65ff06f          	j	2998 <number+0x244>
    2a38:	ffe68693          	addi	a3,a3,-2
    2a3c:	02000f13          	li	t5,32
    2a40:	da1ff06f          	j	27e0 <number+0x8c>
    2a44:	03000693          	li	a3,48
    2a48:	00d88023          	sb	a3,0(a7)
    2a4c:	00188893          	addi	a7,a7,1
    2a50:	f05ff06f          	j	2954 <number+0x200>
    2a54:	fff00493          	li	s1,-1
    2a58:	eedff06f          	j	2944 <number+0x1f0>
    2a5c:	ffe68693          	addi	a3,a3,-2
    2a60:	02d00393          	li	t2,45
    2a64:	02000f13          	li	t5,32
    2a68:	f31ff06f          	j	2998 <number+0x244>
    2a6c:	03000693          	li	a3,48
    2a70:	00d88023          	sb	a3,0(a7)
    2a74:	00188893          	addi	a7,a7,1
    2a78:	f61ff06f          	j	29d8 <number+0x284>
    2a7c:	ffd68693          	addi	a3,a3,-3
    2a80:	02d00393          	li	t2,45
    2a84:	02000f13          	li	t5,32
    2a88:	f11ff06f          	j	2998 <number+0x244>
    2a8c:	fff48493          	addi	s1,s1,-1
    2a90:	df5ff06f          	j	2884 <number+0x130>

00002a94 <ee_printf>:
    2a94:	b8010113          	addi	sp,sp,-1152
    2a98:	45512223          	sw	s5,1092(sp)
    2a9c:	44112e23          	sw	ra,1116(sp)
    2aa0:	44812c23          	sw	s0,1112(sp)
    2aa4:	44912a23          	sw	s1,1108(sp)
    2aa8:	46b12223          	sw	a1,1124(sp)
    2aac:	46c12423          	sw	a2,1128(sp)
    2ab0:	46d12623          	sw	a3,1132(sp)
    2ab4:	46e12823          	sw	a4,1136(sp)
    2ab8:	46f12a23          	sw	a5,1140(sp)
    2abc:	47012c23          	sw	a6,1144(sp)
    2ac0:	47112e23          	sw	a7,1148(sp)
    2ac4:	00054783          	lbu	a5,0(a0)
    2ac8:	46410a93          	addi	s5,sp,1124
    2acc:	01512a23          	sw	s5,20(sp)
    2ad0:	7c078063          	beqz	a5,3290 <ee_printf+0x7fc>
    2ad4:	45612023          	sw	s6,1088(sp)
    2ad8:	03010493          	addi	s1,sp,48
    2adc:	00004b37          	lui	s6,0x4
    2ae0:	45212823          	sw	s2,1104(sp)
    2ae4:	45312623          	sw	s3,1100(sp)
    2ae8:	45412423          	sw	s4,1096(sp)
    2aec:	43712e23          	sw	s7,1084(sp)
    2af0:	43812c23          	sw	s8,1080(sp)
    2af4:	00050313          	mv	t1,a0
    2af8:	00048813          	mv	a6,s1
    2afc:	e0cb0b13          	addi	s6,s6,-500 # 3e0c <intpat+0x80>
    2b00:	02500b93          	li	s7,37
    2b04:	01000a13          	li	s4,16
    2b08:	00900993          	li	s3,9
    2b0c:	02e00913          	li	s2,46
    2b10:	09778063          	beq	a5,s7,2b90 <ee_printf+0xfc>
    2b14:	00f80023          	sb	a5,0(a6)
    2b18:	00134783          	lbu	a5,1(t1)
    2b1c:	00180813          	addi	a6,a6,1
    2b20:	00130313          	addi	t1,t1,1
    2b24:	fe0796e3          	bnez	a5,2b10 <ee_printf+0x7c>
    2b28:	45012903          	lw	s2,1104(sp)
    2b2c:	44c12983          	lw	s3,1100(sp)
    2b30:	44812a03          	lw	s4,1096(sp)
    2b34:	44012b03          	lw	s6,1088(sp)
    2b38:	43c12b83          	lw	s7,1084(sp)
    2b3c:	43812c03          	lw	s8,1080(sp)
    2b40:	00080023          	sb	zero,0(a6)
    2b44:	03014783          	lbu	a5,48(sp)
    2b48:	74078e63          	beqz	a5,32a4 <ee_printf+0x810>
    2b4c:	00048413          	mv	s0,s1
    2b50:	01810513          	addi	a0,sp,24
    2b54:	00100593          	li	a1,1
    2b58:	00f10c23          	sb	a5,24(sp)
    2b5c:	02d000ef          	jal	3388 <uart_write>
    2b60:	00040513          	mv	a0,s0
    2b64:	00144783          	lbu	a5,1(s0)
    2b68:	00140413          	addi	s0,s0,1
    2b6c:	fe0792e3          	bnez	a5,2b50 <ee_printf+0xbc>
    2b70:	45c12083          	lw	ra,1116(sp)
    2b74:	45812403          	lw	s0,1112(sp)
    2b78:	40950533          	sub	a0,a0,s1
    2b7c:	44412a83          	lw	s5,1092(sp)
    2b80:	45412483          	lw	s1,1108(sp)
    2b84:	00150513          	addi	a0,a0,1
    2b88:	48010113          	addi	sp,sp,1152
    2b8c:	00008067          	ret
    2b90:	00000793          	li	a5,0
    2b94:	00134603          	lbu	a2,1(t1)
    2b98:	00130413          	addi	s0,t1,1
    2b9c:	fe060713          	addi	a4,a2,-32
    2ba0:	0ff77713          	zext.b	a4,a4
    2ba4:	00ea6a63          	bltu	s4,a4,2bb8 <ee_printf+0x124>
    2ba8:	00271713          	slli	a4,a4,0x2
    2bac:	01670733          	add	a4,a4,s6
    2bb0:	00072703          	lw	a4,0(a4)
    2bb4:	00070067          	jr	a4
    2bb8:	fd060713          	addi	a4,a2,-48
    2bbc:	0ff77713          	zext.b	a4,a4
    2bc0:	10e9f463          	bgeu	s3,a4,2cc8 <ee_printf+0x234>
    2bc4:	02a00713          	li	a4,42
    2bc8:	fff00693          	li	a3,-1
    2bcc:	12e60863          	beq	a2,a4,2cfc <ee_printf+0x268>
    2bd0:	fff00713          	li	a4,-1
    2bd4:	0d260463          	beq	a2,s2,2c9c <ee_printf+0x208>
    2bd8:	0df67593          	andi	a1,a2,223
    2bdc:	04c00513          	li	a0,76
    2be0:	08a59a63          	bne	a1,a0,2c74 <ee_printf+0x1e0>
    2be4:	00060893          	mv	a7,a2
    2be8:	00144603          	lbu	a2,1(s0)
    2bec:	03700513          	li	a0,55
    2bf0:	00140c13          	addi	s8,s0,1
    2bf4:	fbf60593          	addi	a1,a2,-65
    2bf8:	0ff5f593          	zext.b	a1,a1
    2bfc:	04b56c63          	bltu	a0,a1,2c54 <ee_printf+0x1c0>
    2c00:	00004537          	lui	a0,0x4
    2c04:	00259593          	slli	a1,a1,0x2
    2c08:	e5050513          	addi	a0,a0,-432 # 3e50 <intpat+0xc4>
    2c0c:	00a585b3          	add	a1,a1,a0
    2c10:	0005a583          	lw	a1,0(a1)
    2c14:	00058067          	jr	a1
    2c18:	0017e793          	ori	a5,a5,1
    2c1c:	00040313          	mv	t1,s0
    2c20:	f75ff06f          	j	2b94 <ee_printf+0x100>
    2c24:	0107e793          	ori	a5,a5,16
    2c28:	00040313          	mv	t1,s0
    2c2c:	f69ff06f          	j	2b94 <ee_printf+0x100>
    2c30:	0047e793          	ori	a5,a5,4
    2c34:	00040313          	mv	t1,s0
    2c38:	f5dff06f          	j	2b94 <ee_printf+0x100>
    2c3c:	0207e793          	ori	a5,a5,32
    2c40:	00040313          	mv	t1,s0
    2c44:	f51ff06f          	j	2b94 <ee_printf+0x100>
    2c48:	0087e793          	ori	a5,a5,8
    2c4c:	00040313          	mv	t1,s0
    2c50:	f45ff06f          	j	2b94 <ee_printf+0x100>
    2c54:	000c0413          	mv	s0,s8
    2c58:	02500793          	li	a5,37
    2c5c:	28f60463          	beq	a2,a5,2ee4 <ee_printf+0x450>
    2c60:	00f80023          	sb	a5,0(a6)
    2c64:	00044783          	lbu	a5,0(s0)
    2c68:	00180813          	addi	a6,a6,1
    2c6c:	ea078ee3          	beqz	a5,2b28 <ee_printf+0x94>
    2c70:	2780006f          	j	2ee8 <ee_printf+0x454>
    2c74:	fbf60593          	addi	a1,a2,-65
    2c78:	0ff5f593          	zext.b	a1,a1
    2c7c:	03700513          	li	a0,55
    2c80:	fcb56ce3          	bltu	a0,a1,2c58 <ee_printf+0x1c4>
    2c84:	00004537          	lui	a0,0x4
    2c88:	00259593          	slli	a1,a1,0x2
    2c8c:	f3050513          	addi	a0,a0,-208 # 3f30 <intpat+0x1a4>
    2c90:	00a585b3          	add	a1,a1,a0
    2c94:	0005a583          	lw	a1,0(a1)
    2c98:	00058067          	jr	a1
    2c9c:	00144603          	lbu	a2,1(s0)
    2ca0:	00900893          	li	a7,9
    2ca4:	00140593          	addi	a1,s0,1
    2ca8:	fd060713          	addi	a4,a2,-48
    2cac:	0ff77713          	zext.b	a4,a4
    2cb0:	1ce8fa63          	bgeu	a7,a4,2e84 <ee_printf+0x3f0>
    2cb4:	02a00713          	li	a4,42
    2cb8:	20e60663          	beq	a2,a4,2ec4 <ee_printf+0x430>
    2cbc:	00058413          	mv	s0,a1
    2cc0:	00000713          	li	a4,0
    2cc4:	f15ff06f          	j	2bd8 <ee_printf+0x144>
    2cc8:	00000693          	li	a3,0
    2ccc:	00900593          	li	a1,9
    2cd0:	00269713          	slli	a4,a3,0x2
    2cd4:	00d70733          	add	a4,a4,a3
    2cd8:	00140413          	addi	s0,s0,1
    2cdc:	00171713          	slli	a4,a4,0x1
    2ce0:	00c70733          	add	a4,a4,a2
    2ce4:	00044603          	lbu	a2,0(s0)
    2ce8:	fd070693          	addi	a3,a4,-48
    2cec:	fd060713          	addi	a4,a2,-48
    2cf0:	0ff77713          	zext.b	a4,a4
    2cf4:	fce5fee3          	bgeu	a1,a4,2cd0 <ee_printf+0x23c>
    2cf8:	ed9ff06f          	j	2bd0 <ee_printf+0x13c>
    2cfc:	000aa683          	lw	a3,0(s5)
    2d00:	00234603          	lbu	a2,2(t1)
    2d04:	00230413          	addi	s0,t1,2
    2d08:	0006c663          	bltz	a3,2d14 <ee_printf+0x280>
    2d0c:	004a8a93          	addi	s5,s5,4
    2d10:	ec1ff06f          	j	2bd0 <ee_printf+0x13c>
    2d14:	40d006b3          	neg	a3,a3
    2d18:	0107e793          	ori	a5,a5,16
    2d1c:	004a8a93          	addi	s5,s5,4
    2d20:	eb1ff06f          	j	2bd0 <ee_printf+0x13c>
    2d24:	0407e793          	ori	a5,a5,64
    2d28:	01000613          	li	a2,16
    2d2c:	000aa583          	lw	a1,0(s5)
    2d30:	004a8a93          	addi	s5,s5,4
    2d34:	00080513          	mv	a0,a6
    2d38:	a1dff0ef          	jal	2754 <number>
    2d3c:	001c4783          	lbu	a5,1(s8)
    2d40:	00050813          	mv	a6,a0
    2d44:	001c0313          	addi	t1,s8,1
    2d48:	dc0794e3          	bnez	a5,2b10 <ee_printf+0x7c>
    2d4c:	dddff06f          	j	2b28 <ee_printf+0x94>
    2d50:	00040c13          	mv	s8,s0
    2d54:	00a00613          	li	a2,10
    2d58:	fd5ff06f          	j	2d2c <ee_printf+0x298>
    2d5c:	000c0413          	mv	s0,s8
    2d60:	0107f793          	andi	a5,a5,16
    2d64:	004a8c13          	addi	s8,s5,4
    2d68:	00140313          	addi	t1,s0,1
    2d6c:	1a078863          	beqz	a5,2f1c <ee_printf+0x488>
    2d70:	000aa603          	lw	a2,0(s5)
    2d74:	00100713          	li	a4,1
    2d78:	00c80023          	sb	a2,0(a6)
    2d7c:	5ed75063          	bge	a4,a3,335c <ee_printf+0x8c8>
    2d80:	fff68a93          	addi	s5,a3,-1
    2d84:	000a8613          	mv	a2,s5
    2d88:	00e80533          	add	a0,a6,a4
    2d8c:	02000593          	li	a1,32
    2d90:	00612423          	sw	t1,8(sp)
    2d94:	66c000ef          	jal	3400 <memset>
    2d98:	00144783          	lbu	a5,1(s0)
    2d9c:	01550833          	add	a6,a0,s5
    2da0:	00812303          	lw	t1,8(sp)
    2da4:	000c0a93          	mv	s5,s8
    2da8:	d60794e3          	bnez	a5,2b10 <ee_printf+0x7c>
    2dac:	d7dff06f          	j	2b28 <ee_printf+0x94>
    2db0:	000c0413          	mv	s0,s8
    2db4:	000aa883          	lw	a7,0(s5)
    2db8:	004a8a93          	addi	s5,s5,4
    2dbc:	14088863          	beqz	a7,2f0c <ee_printf+0x478>
    2dc0:	0008c603          	lbu	a2,0(a7)
    2dc4:	0107f793          	andi	a5,a5,16
    2dc8:	56060463          	beqz	a2,3330 <ee_printf+0x89c>
    2dcc:	00e88533          	add	a0,a7,a4
    2dd0:	00088713          	mv	a4,a7
    2dd4:	00e50a63          	beq	a0,a4,2de8 <ee_printf+0x354>
    2dd8:	00174603          	lbu	a2,1(a4)
    2ddc:	00170713          	addi	a4,a4,1
    2de0:	fe061ae3          	bnez	a2,2dd4 <ee_printf+0x340>
    2de4:	00070513          	mv	a0,a4
    2de8:	41150c33          	sub	s8,a0,a7
    2dec:	16078e63          	beqz	a5,2f68 <ee_printf+0x4d4>
    2df0:	03805263          	blez	s8,2e14 <ee_printf+0x380>
    2df4:	01888633          	add	a2,a7,s8
    2df8:	00080793          	mv	a5,a6
    2dfc:	0008c703          	lbu	a4,0(a7)
    2e00:	00188893          	addi	a7,a7,1
    2e04:	00178793          	addi	a5,a5,1
    2e08:	fee78fa3          	sb	a4,-1(a5)
    2e0c:	fec898e3          	bne	a7,a2,2dfc <ee_printf+0x368>
    2e10:	01880833          	add	a6,a6,s8
    2e14:	00140313          	addi	t1,s0,1
    2e18:	52dc5463          	bge	s8,a3,3340 <ee_printf+0x8ac>
    2e1c:	41868633          	sub	a2,a3,s8
    2e20:	00080513          	mv	a0,a6
    2e24:	02000593          	li	a1,32
    2e28:	00612623          	sw	t1,12(sp)
    2e2c:	00d12423          	sw	a3,8(sp)
    2e30:	5d0000ef          	jal	3400 <memset>
    2e34:	00812683          	lw	a3,8(sp)
    2e38:	00144783          	lbu	a5,1(s0)
    2e3c:	00c12303          	lw	t1,12(sp)
    2e40:	00d506b3          	add	a3,a0,a3
    2e44:	41868833          	sub	a6,a3,s8
    2e48:	cc0794e3          	bnez	a5,2b10 <ee_printf+0x7c>
    2e4c:	cddff06f          	j	2b28 <ee_printf+0x94>
    2e50:	000c0413          	mv	s0,s8
    2e54:	fff00613          	li	a2,-1
    2e58:	0ac68463          	beq	a3,a2,2f00 <ee_printf+0x46c>
    2e5c:	000aa583          	lw	a1,0(s5)
    2e60:	00080513          	mv	a0,a6
    2e64:	01000613          	li	a2,16
    2e68:	8edff0ef          	jal	2754 <number>
    2e6c:	00144783          	lbu	a5,1(s0)
    2e70:	004a8a93          	addi	s5,s5,4
    2e74:	00050813          	mv	a6,a0
    2e78:	00140313          	addi	t1,s0,1
    2e7c:	c8079ae3          	bnez	a5,2b10 <ee_printf+0x7c>
    2e80:	ca9ff06f          	j	2b28 <ee_printf+0x94>
    2e84:	00000513          	li	a0,0
    2e88:	00251713          	slli	a4,a0,0x2
    2e8c:	00a70733          	add	a4,a4,a0
    2e90:	00158593          	addi	a1,a1,1
    2e94:	00171713          	slli	a4,a4,0x1
    2e98:	00c70733          	add	a4,a4,a2
    2e9c:	0005c603          	lbu	a2,0(a1)
    2ea0:	fd070513          	addi	a0,a4,-48
    2ea4:	fd060713          	addi	a4,a2,-48
    2ea8:	0ff77713          	zext.b	a4,a4
    2eac:	fce8fee3          	bgeu	a7,a4,2e88 <ee_printf+0x3f4>
    2eb0:	fff54713          	not	a4,a0
    2eb4:	41f75713          	srai	a4,a4,0x1f
    2eb8:	00058413          	mv	s0,a1
    2ebc:	00e57733          	and	a4,a0,a4
    2ec0:	d19ff06f          	j	2bd8 <ee_printf+0x144>
    2ec4:	000aa703          	lw	a4,0(s5)
    2ec8:	00244603          	lbu	a2,2(s0)
    2ecc:	004a8a93          	addi	s5,s5,4
    2ed0:	fff74593          	not	a1,a4
    2ed4:	41f5d593          	srai	a1,a1,0x1f
    2ed8:	00b77733          	and	a4,a4,a1
    2edc:	00240413          	addi	s0,s0,2
    2ee0:	cf9ff06f          	j	2bd8 <ee_printf+0x144>
    2ee4:	00044783          	lbu	a5,0(s0)
    2ee8:	00f80023          	sb	a5,0(a6)
    2eec:	00144783          	lbu	a5,1(s0)
    2ef0:	00180813          	addi	a6,a6,1
    2ef4:	00140313          	addi	t1,s0,1
    2ef8:	c0079ce3          	bnez	a5,2b10 <ee_printf+0x7c>
    2efc:	c2dff06f          	j	2b28 <ee_printf+0x94>
    2f00:	0017e793          	ori	a5,a5,1
    2f04:	00800693          	li	a3,8
    2f08:	f55ff06f          	j	2e5c <ee_printf+0x3c8>
    2f0c:	000048b7          	lui	a7,0x4
    2f10:	0107f793          	andi	a5,a5,16
    2f14:	e0488893          	addi	a7,a7,-508 # 3e04 <intpat+0x78>
    2f18:	eb5ff06f          	j	2dcc <ee_printf+0x338>
    2f1c:	00100793          	li	a5,1
    2f20:	3ed7d663          	bge	a5,a3,330c <ee_printf+0x878>
    2f24:	fff68613          	addi	a2,a3,-1
    2f28:	00080513          	mv	a0,a6
    2f2c:	02000593          	li	a1,32
    2f30:	00612623          	sw	t1,12(sp)
    2f34:	00d12423          	sw	a3,8(sp)
    2f38:	4c8000ef          	jal	3400 <memset>
    2f3c:	00812683          	lw	a3,8(sp)
    2f40:	000aa783          	lw	a5,0(s5)
    2f44:	fff50813          	addi	a6,a0,-1
    2f48:	00c12303          	lw	t1,12(sp)
    2f4c:	00d80833          	add	a6,a6,a3
    2f50:	00f80023          	sb	a5,0(a6)
    2f54:	00180813          	addi	a6,a6,1
    2f58:	00144783          	lbu	a5,1(s0)
    2f5c:	000c0a93          	mv	s5,s8
    2f60:	ba0798e3          	bnez	a5,2b10 <ee_printf+0x7c>
    2f64:	bc5ff06f          	j	2b28 <ee_printf+0x94>
    2f68:	3cdc5063          	bge	s8,a3,3328 <ee_printf+0x894>
    2f6c:	41868633          	sub	a2,a3,s8
    2f70:	00080513          	mv	a0,a6
    2f74:	02000593          	li	a1,32
    2f78:	01112623          	sw	a7,12(sp)
    2f7c:	00d12423          	sw	a3,8(sp)
    2f80:	480000ef          	jal	3400 <memset>
    2f84:	00812683          	lw	a3,8(sp)
    2f88:	00c12883          	lw	a7,12(sp)
    2f8c:	00d506b3          	add	a3,a0,a3
    2f90:	41868833          	sub	a6,a3,s8
    2f94:	fffc0693          	addi	a3,s8,-1
    2f98:	e59ff06f          	j	2df0 <ee_printf+0x35c>
    2f9c:	06c00613          	li	a2,108
    2fa0:	0027e793          	ori	a5,a5,2
    2fa4:	dac888e3          	beq	a7,a2,2d54 <ee_printf+0x2c0>
    2fa8:	000aa583          	lw	a1,0(s5)
    2fac:	00a00613          	li	a2,10
    2fb0:	004a8a93          	addi	s5,s5,4
    2fb4:	d81ff06f          	j	2d34 <ee_printf+0x2a0>
    2fb8:	06c00713          	li	a4,108
    2fbc:	30e88263          	beq	a7,a4,32c0 <ee_printf+0x82c>
    2fc0:	000aa303          	lw	t1,0(s5)
    2fc4:	004a8a93          	addi	s5,s5,4
    2fc8:	00034703          	lbu	a4,0(t1)
    2fcc:	26070863          	beqz	a4,323c <ee_printf+0x7a8>
    2fd0:	00000893          	li	a7,0
    2fd4:	00000513          	li	a0,0
    2fd8:	00100413          	li	s0,1
    2fdc:	06300613          	li	a2,99
    2fe0:	24e65463          	bge	a2,a4,3228 <ee_printf+0x794>
    2fe4:	51eb85b7          	lui	a1,0x51eb8
    2fe8:	51f58593          	addi	a1,a1,1311 # 51eb851f <_stack_start+0x51eb051f>
    2fec:	02b735b3          	mulhu	a1,a4,a1
    2ff0:	06400e93          	li	t4,100
    2ff4:	00004637          	lui	a2,0x4
    2ff8:	db460613          	addi	a2,a2,-588 # 3db4 <intpat+0x28>
    2ffc:	ccccde37          	lui	t3,0xccccd
    3000:	ccde0e13          	addi	t3,t3,-819 # cccccccd <_stack_start+0xcccc4ccd>
    3004:	00240433          	add	s0,s0,sp
    3008:	0055d593          	srli	a1,a1,0x5
    300c:	03d58eb3          	mul	t4,a1,t4
    3010:	00b605b3          	add	a1,a2,a1
    3014:	0005cf03          	lbu	t5,0(a1)
    3018:	002505b3          	add	a1,a0,sp
    301c:	00250513          	addi	a0,a0,2
    3020:	01e58c23          	sb	t5,24(a1)
    3024:	41d705b3          	sub	a1,a4,t4
    3028:	03c5b733          	mulhu	a4,a1,t3
    302c:	00375713          	srli	a4,a4,0x3
    3030:	00e60e33          	add	t3,a2,a4
    3034:	000e4e83          	lbu	t4,0(t3)
    3038:	00271e13          	slli	t3,a4,0x2
    303c:	00ee0733          	add	a4,t3,a4
    3040:	00171713          	slli	a4,a4,0x1
    3044:	01d40c23          	sb	t4,24(s0)
    3048:	40e58733          	sub	a4,a1,a4
    304c:	00e60633          	add	a2,a2,a4
    3050:	00064603          	lbu	a2,0(a2)
    3054:	00250733          	add	a4,a0,sp
    3058:	00188893          	addi	a7,a7,1
    305c:	00c70c23          	sb	a2,24(a4)
    3060:	00400713          	li	a4,4
    3064:	00150413          	addi	s0,a0,1
    3068:	02e88e63          	beq	a7,a4,30a4 <ee_printf+0x610>
    306c:	00240733          	add	a4,s0,sp
    3070:	02e00613          	li	a2,46
    3074:	00c70c23          	sb	a2,24(a4)
    3078:	01130733          	add	a4,t1,a7
    307c:	00074703          	lbu	a4,0(a4)
    3080:	00140513          	addi	a0,s0,1
    3084:	00240413          	addi	s0,s0,2
    3088:	f4071ae3          	bnez	a4,2fdc <ee_printf+0x548>
    308c:	03000713          	li	a4,48
    3090:	00250533          	add	a0,a0,sp
    3094:	00e50c23          	sb	a4,24(a0)
    3098:	00188893          	addi	a7,a7,1
    309c:	00400713          	li	a4,4
    30a0:	fce896e3          	bne	a7,a4,306c <ee_printf+0x5d8>
    30a4:	0107f793          	andi	a5,a5,16
    30a8:	02079663          	bnez	a5,30d4 <ee_printf+0x640>
    30ac:	2ad45063          	bge	s0,a3,334c <ee_printf+0x8b8>
    30b0:	40868633          	sub	a2,a3,s0
    30b4:	00080513          	mv	a0,a6
    30b8:	02000593          	li	a1,32
    30bc:	00d12423          	sw	a3,8(sp)
    30c0:	340000ef          	jal	3400 <memset>
    30c4:	00812683          	lw	a3,8(sp)
    30c8:	00d506b3          	add	a3,a0,a3
    30cc:	40868833          	sub	a6,a3,s0
    30d0:	fff40693          	addi	a3,s0,-1
    30d4:	02805063          	blez	s0,30f4 <ee_printf+0x660>
    30d8:	00080513          	mv	a0,a6
    30dc:	00040613          	mv	a2,s0
    30e0:	01810593          	addi	a1,sp,24
    30e4:	00d12423          	sw	a3,8(sp)
    30e8:	3f4000ef          	jal	34dc <memcpy>
    30ec:	00812683          	lw	a3,8(sp)
    30f0:	00850833          	add	a6,a0,s0
    30f4:	00d45e63          	bge	s0,a3,3110 <ee_printf+0x67c>
    30f8:	40868433          	sub	s0,a3,s0
    30fc:	00080513          	mv	a0,a6
    3100:	00040613          	mv	a2,s0
    3104:	02000593          	li	a1,32
    3108:	2f8000ef          	jal	3400 <memset>
    310c:	00850833          	add	a6,a0,s0
    3110:	001c4783          	lbu	a5,1(s8)
    3114:	001c0313          	addi	t1,s8,1
    3118:	9e079ce3          	bnez	a5,2b10 <ee_printf+0x7c>
    311c:	a0dff06f          	j	2b28 <ee_printf+0x94>
    3120:	06c00713          	li	a4,108
    3124:	0407e793          	ori	a5,a5,64
    3128:	e8e89ce3          	bne	a7,a4,2fc0 <ee_printf+0x52c>
    312c:	00004737          	lui	a4,0x4
    3130:	000aae83          	lw	t4,0(s5)
    3134:	ddc70713          	addi	a4,a4,-548 # 3ddc <intpat+0x50>
    3138:	004a8a93          	addi	s5,s5,4
    313c:	00000893          	li	a7,0
    3140:	00000513          	li	a0,0
    3144:	00600e13          	li	t3,6
    3148:	03a00f13          	li	t5,58
    314c:	0100006f          	j	315c <ee_printf+0x6c8>
    3150:	01fc0c33          	add	s8,s8,t6
    3154:	01ec0423          	sb	t5,8(s8)
    3158:	00350513          	addi	a0,a0,3
    315c:	011e8633          	add	a2,t4,a7
    3160:	00064603          	lbu	a2,0(a2)
    3164:	01010f93          	addi	t6,sp,16
    3168:	00188893          	addi	a7,a7,1
    316c:	00465593          	srli	a1,a2,0x4
    3170:	00b705b3          	add	a1,a4,a1
    3174:	0005c303          	lbu	t1,0(a1)
    3178:	00f67613          	andi	a2,a2,15
    317c:	00c70633          	add	a2,a4,a2
    3180:	00064583          	lbu	a1,0(a2)
    3184:	01f50633          	add	a2,a0,t6
    3188:	00660423          	sb	t1,8(a2)
    318c:	00150313          	addi	t1,a0,1
    3190:	01f30633          	add	a2,t1,t6
    3194:	00b60423          	sb	a1,8(a2)
    3198:	00250c13          	addi	s8,a0,2
    319c:	fbc89ae3          	bne	a7,t3,3150 <ee_printf+0x6bc>
    31a0:	0107f793          	andi	a5,a5,16
    31a4:	02079863          	bnez	a5,31d4 <ee_printf+0x740>
    31a8:	1adc5663          	bge	s8,a3,3354 <ee_printf+0x8c0>
    31ac:	41868633          	sub	a2,a3,s8
    31b0:	00080513          	mv	a0,a6
    31b4:	02000593          	li	a1,32
    31b8:	00d12423          	sw	a3,8(sp)
    31bc:	00612623          	sw	t1,12(sp)
    31c0:	240000ef          	jal	3400 <memset>
    31c4:	00812683          	lw	a3,8(sp)
    31c8:	00d506b3          	add	a3,a0,a3
    31cc:	41868833          	sub	a6,a3,s8
    31d0:	00c12683          	lw	a3,12(sp)
    31d4:	00080513          	mv	a0,a6
    31d8:	000c0613          	mv	a2,s8
    31dc:	01810593          	addi	a1,sp,24
    31e0:	00d12423          	sw	a3,8(sp)
    31e4:	2f8000ef          	jal	34dc <memcpy>
    31e8:	00812683          	lw	a3,8(sp)
    31ec:	01850833          	add	a6,a0,s8
    31f0:	00dc5e63          	bge	s8,a3,320c <ee_printf+0x778>
    31f4:	41868c33          	sub	s8,a3,s8
    31f8:	00080513          	mv	a0,a6
    31fc:	000c0613          	mv	a2,s8
    3200:	02000593          	li	a1,32
    3204:	1fc000ef          	jal	3400 <memset>
    3208:	01850833          	add	a6,a0,s8
    320c:	00244783          	lbu	a5,2(s0)
    3210:	00240313          	addi	t1,s0,2
    3214:	8e079ee3          	bnez	a5,2b10 <ee_printf+0x7c>
    3218:	911ff06f          	j	2b28 <ee_printf+0x94>
    321c:	00040c13          	mv	s8,s0
    3220:	00800613          	li	a2,8
    3224:	b09ff06f          	j	2d2c <ee_printf+0x298>
    3228:	00900613          	li	a2,9
    322c:	02e64263          	blt	a2,a4,3250 <ee_printf+0x7bc>
    3230:	00004637          	lui	a2,0x4
    3234:	db460613          	addi	a2,a2,-588 # 3db4 <intpat+0x28>
    3238:	e15ff06f          	j	304c <ee_printf+0x5b8>
    323c:	03000713          	li	a4,48
    3240:	00100413          	li	s0,1
    3244:	00e10c23          	sb	a4,24(sp)
    3248:	00040893          	mv	a7,s0
    324c:	e21ff06f          	j	306c <ee_printf+0x5d8>
    3250:	ccccd5b7          	lui	a1,0xccccd
    3254:	ccd58593          	addi	a1,a1,-819 # cccccccd <_stack_start+0xcccc4ccd>
    3258:	02b735b3          	mulhu	a1,a4,a1
    325c:	00004637          	lui	a2,0x4
    3260:	db460613          	addi	a2,a2,-588 # 3db4 <intpat+0x28>
    3264:	00250eb3          	add	t4,a0,sp
    3268:	00040513          	mv	a0,s0
    326c:	0035d593          	srli	a1,a1,0x3
    3270:	00b60e33          	add	t3,a2,a1
    3274:	000e4f03          	lbu	t5,0(t3)
    3278:	00259e13          	slli	t3,a1,0x2
    327c:	00be05b3          	add	a1,t3,a1
    3280:	00159593          	slli	a1,a1,0x1
    3284:	01ee8c23          	sb	t5,24(t4)
    3288:	40b70733          	sub	a4,a4,a1
    328c:	dc1ff06f          	j	304c <ee_printf+0x5b8>
    3290:	03010493          	addi	s1,sp,48
    3294:	00048813          	mv	a6,s1
    3298:	00080023          	sb	zero,0(a6)
    329c:	03014783          	lbu	a5,48(sp)
    32a0:	8a0796e3          	bnez	a5,2b4c <ee_printf+0xb8>
    32a4:	45c12083          	lw	ra,1116(sp)
    32a8:	45812403          	lw	s0,1112(sp)
    32ac:	45412483          	lw	s1,1108(sp)
    32b0:	44412a83          	lw	s5,1092(sp)
    32b4:	00000513          	li	a0,0
    32b8:	48010113          	addi	sp,sp,1152
    32bc:	00008067          	ret
    32c0:	00004637          	lui	a2,0x4
    32c4:	000aae83          	lw	t4,0(s5)
    32c8:	db460713          	addi	a4,a2,-588 # 3db4 <intpat+0x28>
    32cc:	004a8a93          	addi	s5,s5,4
    32d0:	e6dff06f          	j	313c <ee_printf+0x6a8>
    32d4:	0027e793          	ori	a5,a5,2
    32d8:	00040c13          	mv	s8,s0
    32dc:	ccdff06f          	j	2fa8 <ee_printf+0x514>
    32e0:	00040c13          	mv	s8,s0
    32e4:	cddff06f          	j	2fc0 <ee_printf+0x52c>
    32e8:	00040c13          	mv	s8,s0
    32ec:	a3dff06f          	j	2d28 <ee_printf+0x294>
    32f0:	0407e793          	ori	a5,a5,64
    32f4:	00040c13          	mv	s8,s0
    32f8:	cc9ff06f          	j	2fc0 <ee_printf+0x52c>
    32fc:	0407e793          	ori	a5,a5,64
    3300:	00040c13          	mv	s8,s0
    3304:	01000613          	li	a2,16
    3308:	a25ff06f          	j	2d2c <ee_printf+0x298>
    330c:	000aa783          	lw	a5,0(s5)
    3310:	00180813          	addi	a6,a6,1
    3314:	000c0a93          	mv	s5,s8
    3318:	fef80fa3          	sb	a5,-1(a6)
    331c:	00144783          	lbu	a5,1(s0)
    3320:	fe079863          	bnez	a5,2b10 <ee_printf+0x7c>
    3324:	805ff06f          	j	2b28 <ee_printf+0x94>
    3328:	fff68693          	addi	a3,a3,-1
    332c:	ac5ff06f          	j	2df0 <ee_printf+0x35c>
    3330:	00000c13          	li	s8,0
    3334:	ae0790e3          	bnez	a5,2e14 <ee_printf+0x380>
    3338:	00140313          	addi	t1,s0,1
    333c:	c2d048e3          	bgtz	a3,2f6c <ee_printf+0x4d8>
    3340:	00144783          	lbu	a5,1(s0)
    3344:	fc079663          	bnez	a5,2b10 <ee_printf+0x7c>
    3348:	fe0ff06f          	j	2b28 <ee_printf+0x94>
    334c:	fff68693          	addi	a3,a3,-1
    3350:	d85ff06f          	j	30d4 <ee_printf+0x640>
    3354:	fff68693          	addi	a3,a3,-1
    3358:	e7dff06f          	j	31d4 <ee_printf+0x740>
    335c:	00e80833          	add	a6,a6,a4
    3360:	bf9ff06f          	j	2f58 <ee_printf+0x4c4>

00003364 <uart_enable>:
    3364:	80000737          	lui	a4,0x80000
    3368:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fff8000>
    336c:	00357513          	andi	a0,a0,3
    3370:	fff54513          	not	a0,a0
    3374:	00a7f7b3          	and	a5,a5,a0
    3378:	00005537          	lui	a0,0x5
    337c:	00f70023          	sb	a5,0(a4)
    3380:	80050513          	addi	a0,a0,-2048 # 4800 <uart_read_buff>
    3384:	06c0006f          	j	33f0 <circ_buf_init>

00003388 <uart_write>:
    3388:	04058463          	beqz	a1,33d0 <uart_write+0x48>
    338c:	80000637          	lui	a2,0x80000
    3390:	00b506b3          	add	a3,a0,a1
    3394:	00160613          	addi	a2,a2,1 # 80000001 <_stack_start+0x7fff8001>
    3398:	80000737          	lui	a4,0x80000
    339c:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fff8000>
    33a0:	0047f793          	andi	a5,a5,4
    33a4:	fe078ce3          	beqz	a5,339c <uart_write+0x14>
    33a8:	00054783          	lbu	a5,0(a0)
    33ac:	00150513          	addi	a0,a0,1
    33b0:	00f60023          	sb	a5,0(a2)
    33b4:	00074783          	lbu	a5,0(a4)
    33b8:	0107e793          	ori	a5,a5,16
    33bc:	00f70023          	sb	a5,0(a4)
    33c0:	00074783          	lbu	a5,0(a4)
    33c4:	0ef7f793          	andi	a5,a5,239
    33c8:	00f70023          	sb	a5,0(a4)
    33cc:	fcd518e3          	bne	a0,a3,339c <uart_write+0x14>
    33d0:	80000737          	lui	a4,0x80000
    33d4:	00074783          	lbu	a5,0(a4) # 80000000 <_stack_start+0x7fff8000>
    33d8:	0ef7f793          	andi	a5,a5,239
    33dc:	00f70023          	sb	a5,0(a4)
    33e0:	00074783          	lbu	a5,0(a4)
    33e4:	0047f793          	andi	a5,a5,4
    33e8:	fe078ce3          	beqz	a5,33e0 <uart_write+0x58>
    33ec:	00008067          	ret

000033f0 <circ_buf_init>:
    33f0:	080500a3          	sb	zero,129(a0)
    33f4:	00050023          	sb	zero,0(a0)
    33f8:	08050123          	sb	zero,130(a0)
    33fc:	00008067          	ret

00003400 <memset>:
    3400:	00f00313          	li	t1,15
    3404:	00050713          	mv	a4,a0
    3408:	02c37e63          	bgeu	t1,a2,3444 <memset+0x44>
    340c:	00f77793          	andi	a5,a4,15
    3410:	0a079063          	bnez	a5,34b0 <memset+0xb0>
    3414:	08059263          	bnez	a1,3498 <memset+0x98>
    3418:	ff067693          	andi	a3,a2,-16
    341c:	00f67613          	andi	a2,a2,15
    3420:	00e686b3          	add	a3,a3,a4
    3424:	00b72023          	sw	a1,0(a4)
    3428:	00b72223          	sw	a1,4(a4)
    342c:	00b72423          	sw	a1,8(a4)
    3430:	00b72623          	sw	a1,12(a4)
    3434:	01070713          	addi	a4,a4,16
    3438:	fed766e3          	bltu	a4,a3,3424 <memset+0x24>
    343c:	00061463          	bnez	a2,3444 <memset+0x44>
    3440:	00008067          	ret
    3444:	40c306b3          	sub	a3,t1,a2
    3448:	00269693          	slli	a3,a3,0x2
    344c:	00000297          	auipc	t0,0x0
    3450:	005686b3          	add	a3,a3,t0
    3454:	00c68067          	jr	12(a3)
    3458:	00b70723          	sb	a1,14(a4)
    345c:	00b706a3          	sb	a1,13(a4)
    3460:	00b70623          	sb	a1,12(a4)
    3464:	00b705a3          	sb	a1,11(a4)
    3468:	00b70523          	sb	a1,10(a4)
    346c:	00b704a3          	sb	a1,9(a4)
    3470:	00b70423          	sb	a1,8(a4)
    3474:	00b703a3          	sb	a1,7(a4)
    3478:	00b70323          	sb	a1,6(a4)
    347c:	00b702a3          	sb	a1,5(a4)
    3480:	00b70223          	sb	a1,4(a4)
    3484:	00b701a3          	sb	a1,3(a4)
    3488:	00b70123          	sb	a1,2(a4)
    348c:	00b700a3          	sb	a1,1(a4)
    3490:	00b70023          	sb	a1,0(a4)
    3494:	00008067          	ret
    3498:	0ff5f593          	zext.b	a1,a1
    349c:	00859693          	slli	a3,a1,0x8
    34a0:	00d5e5b3          	or	a1,a1,a3
    34a4:	01059693          	slli	a3,a1,0x10
    34a8:	00d5e5b3          	or	a1,a1,a3
    34ac:	f6dff06f          	j	3418 <memset+0x18>
    34b0:	00279693          	slli	a3,a5,0x2
    34b4:	00000297          	auipc	t0,0x0
    34b8:	005686b3          	add	a3,a3,t0
    34bc:	00008293          	mv	t0,ra
    34c0:	fa0680e7          	jalr	-96(a3)
    34c4:	00028093          	mv	ra,t0
    34c8:	ff078793          	addi	a5,a5,-16
    34cc:	40f70733          	sub	a4,a4,a5
    34d0:	00f60633          	add	a2,a2,a5
    34d4:	f6c378e3          	bgeu	t1,a2,3444 <memset+0x44>
    34d8:	f3dff06f          	j	3414 <memset+0x14>

000034dc <memcpy>:
    34dc:	00a5c7b3          	xor	a5,a1,a0
    34e0:	0037f793          	andi	a5,a5,3
    34e4:	00c508b3          	add	a7,a0,a2
    34e8:	06079663          	bnez	a5,3554 <memcpy+0x78>
    34ec:	00463613          	sltiu	a2,a2,4
    34f0:	06061263          	bnez	a2,3554 <memcpy+0x78>
    34f4:	00357793          	andi	a5,a0,3
    34f8:	00050713          	mv	a4,a0
    34fc:	0c079a63          	bnez	a5,35d0 <memcpy+0xf4>
    3500:	ffc8f613          	andi	a2,a7,-4
    3504:	40e606b3          	sub	a3,a2,a4
    3508:	02000793          	li	a5,32
    350c:	06d7c463          	blt	a5,a3,3574 <memcpy+0x98>
    3510:	00058693          	mv	a3,a1
    3514:	00070793          	mv	a5,a4
    3518:	02c77a63          	bgeu	a4,a2,354c <memcpy+0x70>
    351c:	0006a803          	lw	a6,0(a3)
    3520:	00478793          	addi	a5,a5,4
    3524:	00468693          	addi	a3,a3,4
    3528:	ff07ae23          	sw	a6,-4(a5)
    352c:	fec7e8e3          	bltu	a5,a2,351c <memcpy+0x40>
    3530:	fff60613          	addi	a2,a2,-1
    3534:	40e60633          	sub	a2,a2,a4
    3538:	ffc67613          	andi	a2,a2,-4
    353c:	00458593          	addi	a1,a1,4
    3540:	00470713          	addi	a4,a4,4
    3544:	00c585b3          	add	a1,a1,a2
    3548:	00c70733          	add	a4,a4,a2
    354c:	01176863          	bltu	a4,a7,355c <memcpy+0x80>
    3550:	00008067          	ret
    3554:	00050713          	mv	a4,a0
    3558:	ff157ce3          	bgeu	a0,a7,3550 <memcpy+0x74>
    355c:	0005c783          	lbu	a5,0(a1)
    3560:	00170713          	addi	a4,a4,1
    3564:	00158593          	addi	a1,a1,1
    3568:	fef70fa3          	sb	a5,-1(a4)
    356c:	fee898e3          	bne	a7,a4,355c <memcpy+0x80>
    3570:	00008067          	ret
    3574:	0005a683          	lw	a3,0(a1)
    3578:	0045a283          	lw	t0,4(a1)
    357c:	0085af83          	lw	t6,8(a1)
    3580:	00c5af03          	lw	t5,12(a1)
    3584:	0105ae83          	lw	t4,16(a1)
    3588:	0145ae03          	lw	t3,20(a1)
    358c:	0185a303          	lw	t1,24(a1)
    3590:	01c5a803          	lw	a6,28(a1)
    3594:	00d72023          	sw	a3,0(a4)
    3598:	0205a683          	lw	a3,32(a1)
    359c:	02470713          	addi	a4,a4,36
    35a0:	fe572023          	sw	t0,-32(a4)
    35a4:	fed72e23          	sw	a3,-4(a4)
    35a8:	fff72223          	sw	t6,-28(a4)
    35ac:	40e606b3          	sub	a3,a2,a4
    35b0:	ffe72423          	sw	t5,-24(a4)
    35b4:	ffd72623          	sw	t4,-20(a4)
    35b8:	ffc72823          	sw	t3,-16(a4)
    35bc:	fe672a23          	sw	t1,-12(a4)
    35c0:	ff072c23          	sw	a6,-8(a4)
    35c4:	02458593          	addi	a1,a1,36
    35c8:	fad7c6e3          	blt	a5,a3,3574 <memcpy+0x98>
    35cc:	f45ff06f          	j	3510 <memcpy+0x34>
    35d0:	0005c683          	lbu	a3,0(a1)
    35d4:	00170713          	addi	a4,a4,1
    35d8:	00377793          	andi	a5,a4,3
    35dc:	fed70fa3          	sb	a3,-1(a4)
    35e0:	00158593          	addi	a1,a1,1
    35e4:	f0078ee3          	beqz	a5,3500 <memcpy+0x24>
    35e8:	0005c683          	lbu	a3,0(a1)
    35ec:	00170713          	addi	a4,a4,1
    35f0:	00377793          	andi	a5,a4,3
    35f4:	fed70fa3          	sb	a3,-1(a4)
    35f8:	00158593          	addi	a1,a1,1
    35fc:	fc079ae3          	bnez	a5,35d0 <memcpy+0xf4>
    3600:	f01ff06f          	j	3500 <memcpy+0x24>
