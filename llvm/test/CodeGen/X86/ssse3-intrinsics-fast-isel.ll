; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -fast-isel -mtriple=i386-unknown-unknown -mattr=+ssse3 | FileCheck %s --check-prefixes=CHECK,X86,SSE,X86-SSE
; RUN: llc < %s -fast-isel -mtriple=i386-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=CHECK,X86,AVX,X86-AVX,AVX1,X86-AVX1
; RUN: llc < %s -fast-isel -mtriple=i386-unknown-unknown -mattr=+avx512f,+avx512bw,+avx512dq,+avx512vl | FileCheck %s --check-prefixes=CHECK,X86,AVX,X86-AVX,AVX512,X86-AVX512
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+ssse3 | FileCheck %s --check-prefixes=CHECK,X64,SSE,X64-SSE
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=CHECK,X64,AVX,X64-AVX,AVX1,X64-AVX1
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw,+avx512dq,+avx512vl | FileCheck %s --check-prefixes=CHECK,X64,AVX,X64-AVX,AVX512,X64-AVX512

; NOTE: This should use IR equivalent to what is generated by clang/test/CodeGen/ssse3-builtins.c

define <2 x i64> @test_mm_abs_epi8(<2 x i64> %a0) {
; SSE-LABEL: test_mm_abs_epi8:
; SSE:       # %bb.0:
; SSE-NEXT:    pabsb %xmm0, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_abs_epi8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpabsb %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg = bitcast <2 x i64> %a0 to <16 x i8>
  %abs = call <16 x i8> @llvm.abs.v16i8(<16 x i8> %arg, i1 false)
  %res = bitcast <16 x i8> %abs to <2 x i64>
  ret <2 x i64> %res
}
declare <16 x i8> @llvm.abs.v16i8(<16 x i8>, i1) nounwind readnone

define <2 x i64> @test_mm_abs_epi16(<2 x i64> %a0) {
; SSE-LABEL: test_mm_abs_epi16:
; SSE:       # %bb.0:
; SSE-NEXT:    pabsw %xmm0, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_abs_epi16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpabsw %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg = bitcast <2 x i64> %a0 to <8 x i16>
  %abs = call <8 x i16> @llvm.abs.v8i16(<8 x i16> %arg, i1 false)
  %res = bitcast <8 x i16> %abs to <2 x i64>
  ret <2 x i64> %res
}
declare <8 x i16> @llvm.abs.v8i16(<8 x i16>, i1) nounwind readnone

define <2 x i64> @test_mm_abs_epi32(<2 x i64> %a0) {
; SSE-LABEL: test_mm_abs_epi32:
; SSE:       # %bb.0:
; SSE-NEXT:    pabsd %xmm0, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_abs_epi32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpabsd %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg = bitcast <2 x i64> %a0 to <4 x i32>
  %abs = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %arg, i1 false)
  %res = bitcast <4 x i32> %abs to <2 x i64>
  ret <2 x i64> %res
}
declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1) nounwind readnone

define <2 x i64> @test_mm_alignr_epi8(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_alignr_epi8:
; SSE:       # %bb.0:
; SSE-NEXT:    palignr {{.*#+}} xmm1 = xmm0[2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm1[0,1]
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_alignr_epi8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpalignr {{.*#+}} xmm0 = xmm0[2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm1[0,1]
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %shuf = shufflevector <16 x i8> %arg0, <16 x i8> %arg1, <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17>
  %res = bitcast <16 x i8> %shuf to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test2_mm_alignr_epi8(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test2_mm_alignr_epi8:
; SSE:       # %bb.0:
; SSE-NEXT:    palignr {{.*#+}} xmm1 = xmm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm1[0]
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test2_mm_alignr_epi8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpalignr {{.*#+}} xmm0 = xmm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm1[0]
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %shuf = shufflevector <16 x i8> %arg0, <16 x i8> %arg1, <16 x i32> <i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16>
  %res = bitcast <16 x i8> %shuf to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test_mm_hadd_epi16(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_hadd_epi16:
; SSE:       # %bb.0:
; SSE-NEXT:    phaddw %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_hadd_epi16:
; AVX:       # %bb.0:
; AVX-NEXT:    vphaddw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %call = call <8 x i16> @llvm.x86.ssse3.phadd.w.128(<8 x i16> %arg0, <8 x i16> %arg1)
  %res = bitcast <8 x i16> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <8 x i16> @llvm.x86.ssse3.phadd.w.128(<8 x i16>, <8 x i16>) nounwind readnone

define <2 x i64> @test_mm_hadd_epi32(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_hadd_epi32:
; SSE:       # %bb.0:
; SSE-NEXT:    phaddd %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_hadd_epi32:
; AVX:       # %bb.0:
; AVX-NEXT:    vphaddd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %call = call <4 x i32> @llvm.x86.ssse3.phadd.d.128(<4 x i32> %arg0, <4 x i32> %arg1)
  %res = bitcast <4 x i32> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <4 x i32> @llvm.x86.ssse3.phadd.d.128(<4 x i32>, <4 x i32>) nounwind readnone

define <2 x i64> @test_mm_hadds_epi16(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_hadds_epi16:
; SSE:       # %bb.0:
; SSE-NEXT:    phaddsw %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_hadds_epi16:
; AVX:       # %bb.0:
; AVX-NEXT:    vphaddsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %call = call <8 x i16> @llvm.x86.ssse3.phadd.sw.128(<8 x i16> %arg0, <8 x i16> %arg1)
  %res = bitcast <8 x i16> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <8 x i16> @llvm.x86.ssse3.phadd.sw.128(<8 x i16>, <8 x i16>) nounwind readnone

define <2 x i64> @test_mm_hsub_epi16(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_hsub_epi16:
; SSE:       # %bb.0:
; SSE-NEXT:    phsubw %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_hsub_epi16:
; AVX:       # %bb.0:
; AVX-NEXT:    vphsubw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %call = call <8 x i16> @llvm.x86.ssse3.phsub.w.128(<8 x i16> %arg0, <8 x i16> %arg1)
  %res = bitcast <8 x i16> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <8 x i16> @llvm.x86.ssse3.phsub.w.128(<8 x i16>, <8 x i16>) nounwind readnone

define <2 x i64> @test_mm_hsub_epi32(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_hsub_epi32:
; SSE:       # %bb.0:
; SSE-NEXT:    phsubd %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_hsub_epi32:
; AVX:       # %bb.0:
; AVX-NEXT:    vphsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %call = call <4 x i32> @llvm.x86.ssse3.phsub.d.128(<4 x i32> %arg0, <4 x i32> %arg1)
  %res = bitcast <4 x i32> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <4 x i32> @llvm.x86.ssse3.phsub.d.128(<4 x i32>, <4 x i32>) nounwind readnone

define <2 x i64> @test_mm_hsubs_epi16(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_hsubs_epi16:
; SSE:       # %bb.0:
; SSE-NEXT:    phsubsw %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_hsubs_epi16:
; AVX:       # %bb.0:
; AVX-NEXT:    vphsubsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %call = call <8 x i16> @llvm.x86.ssse3.phsub.sw.128(<8 x i16> %arg0, <8 x i16> %arg1)
  %res = bitcast <8 x i16> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <8 x i16> @llvm.x86.ssse3.phsub.sw.128(<8 x i16>, <8 x i16>) nounwind readnone

define <2 x i64> @test_mm_maddubs_epi16(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_maddubs_epi16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmaddubsw %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_maddubs_epi16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmaddubsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %call = call <8 x i16> @llvm.x86.ssse3.pmadd.ub.sw.128(<16 x i8> %arg0, <16 x i8> %arg1)
  %res = bitcast <8 x i16> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <8 x i16> @llvm.x86.ssse3.pmadd.ub.sw.128(<16 x i8>, <16 x i8>) nounwind readnone

define <2 x i64> @test_mm_mulhrs_epi16(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_mulhrs_epi16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhrsw %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_mulhrs_epi16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhrsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %call = call <8 x i16> @llvm.x86.ssse3.pmul.hr.sw.128(<8 x i16> %arg0, <8 x i16> %arg1)
  %res = bitcast <8 x i16> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <8 x i16> @llvm.x86.ssse3.pmul.hr.sw.128(<8 x i16>, <8 x i16>) nounwind readnone

define <2 x i64> @test_mm_shuffle_epi8(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_shuffle_epi8:
; SSE:       # %bb.0:
; SSE-NEXT:    pshufb %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_shuffle_epi8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %call = call <16 x i8> @llvm.x86.ssse3.pshuf.b.128(<16 x i8> %arg0, <16 x i8> %arg1)
  %res = bitcast <16 x i8> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <16 x i8> @llvm.x86.ssse3.pshuf.b.128(<16 x i8>, <16 x i8>) nounwind readnone

define <2 x i64> @test_mm_sign_epi8(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_sign_epi8:
; SSE:       # %bb.0:
; SSE-NEXT:    psignb %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_sign_epi8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsignb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %call = call <16 x i8> @llvm.x86.ssse3.psign.b.128(<16 x i8> %arg0, <16 x i8> %arg1)
  %res = bitcast <16 x i8> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <16 x i8> @llvm.x86.ssse3.psign.b.128(<16 x i8>, <16 x i8>) nounwind readnone

define <2 x i64> @test_mm_sign_epi16(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_sign_epi16:
; SSE:       # %bb.0:
; SSE-NEXT:    psignw %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_sign_epi16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsignw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %call = call <8 x i16> @llvm.x86.ssse3.psign.w.128(<8 x i16> %arg0, <8 x i16> %arg1)
  %res = bitcast <8 x i16> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <8 x i16> @llvm.x86.ssse3.psign.w.128(<8 x i16>, <8 x i16>) nounwind readnone

define <2 x i64> @test_mm_sign_epi32(<2 x i64> %a0, <2 x i64> %a1) {
; SSE-LABEL: test_mm_sign_epi32:
; SSE:       # %bb.0:
; SSE-NEXT:    psignd %xmm1, %xmm0
; SSE-NEXT:    ret{{[l|q]}}
;
; AVX-LABEL: test_mm_sign_epi32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsignd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    ret{{[l|q]}}
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %call = call <4 x i32> @llvm.x86.ssse3.psign.d.128(<4 x i32> %arg0, <4 x i32> %arg1)
  %res = bitcast <4 x i32> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <4 x i32> @llvm.x86.ssse3.psign.d.128(<4 x i32>, <4 x i32>) nounwind readnone
