; ModuleID = 'probe5.59ad65c4532bd03c-cgu.0'
source_filename = "probe5.59ad65c4532bd03c-cgu.0"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-i128:128-n32:64-S128-ni:1:10:20"
target triple = "wasm32-unknown-wasip1"

@alloc_2e38410fced2c310c68bdf2d45d0c3bd = private unnamed_addr constant [4 x i8] c"\02\00\00\00", align 4
@alloc_7971f3465817cc18ad816e3dbdd7087a = private unnamed_addr constant [7 x i8] c"<anon>\00", align 1
@alloc_1a69b8b25227f7c4ff5b17f7d1eaf2eb = private unnamed_addr constant <{ ptr, [12 x i8] }> <{ ptr @alloc_7971f3465817cc18ad816e3dbdd7087a, [12 x i8] c"\06\00\00\00\01\00\00\00+\00\00\00" }>, align 4

; <i32 as core::ops::arith::AddAssign<&i32>>::add_assign
; Function Attrs: inlinehint nounwind
define internal void @"_ZN66_$LT$i32$u20$as$u20$core..ops..arith..AddAssign$LT$$RF$i32$GT$$GT$10add_assign17h059868081f125d68E"(ptr align 4 %self, ptr align 4 %other, ptr align 4 %0) unnamed_addr #0 {
start:
  %other1 = load i32, ptr %other, align 4
  %1 = load i32, ptr %self, align 4
  %2 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %1, i32 %other1)
  %_4.0 = extractvalue { i32, i1 } %2, 0
  %_4.1 = extractvalue { i32, i1 } %2, 1
  br i1 %_4.1, label %panic, label %bb1

bb1:                                              ; preds = %start
  store i32 %_4.0, ptr %self, align 4
  ret void

panic:                                            ; preds = %start
; call core::panicking::panic_const::panic_const_add_overflow
  call void @_ZN4core9panicking11panic_const24panic_const_add_overflow17he3e706d13dda9c08E(ptr align 4 %0) #4
  unreachable
}

; probe5::probe
; Function Attrs: nounwind
define dso_local void @_ZN6probe55probe17h6850c5c99be06922E() unnamed_addr #1 {
start:
  %x = alloca [4 x i8], align 4
  store i32 1, ptr %x, align 4
; call <i32 as core::ops::arith::AddAssign<&i32>>::add_assign
  call void @"_ZN66_$LT$i32$u20$as$u20$core..ops..arith..AddAssign$LT$$RF$i32$GT$$GT$10add_assign17h059868081f125d68E"(ptr align 4 %x, ptr align 4 @alloc_2e38410fced2c310c68bdf2d45d0c3bd, ptr align 4 @alloc_1a69b8b25227f7c4ff5b17f7d1eaf2eb) #5
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) #2

; core::panicking::panic_const::panic_const_add_overflow
; Function Attrs: cold noinline noreturn nounwind
declare dso_local void @_ZN4core9panicking11panic_const24panic_const_add_overflow17he3e706d13dda9c08E(ptr align 4) unnamed_addr #3

attributes #0 = { inlinehint nounwind "target-cpu"="generic" }
attributes #1 = { nounwind "target-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { cold noinline noreturn nounwind "target-cpu"="generic" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"rustc version 1.92.0 (ded5c06cf 2025-12-08)"}
