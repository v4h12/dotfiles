; ModuleID = 'probe6.e7b55499d8cc1f34-cgu.0'
source_filename = "probe6.e7b55499d8cc1f34-cgu.0"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-i128:128-n32:64-S128-ni:1:10:20"
target triple = "wasm32-unknown-wasip1"

@alloc_7971f3465817cc18ad816e3dbdd7087a = private unnamed_addr constant [7 x i8] c"<anon>\00", align 1
@alloc_5c138730b01a94df0b4ba2dcb096bfc5 = private unnamed_addr constant <{ ptr, [12 x i8] }> <{ ptr @alloc_7971f3465817cc18ad816e3dbdd7087a, [12 x i8] c"\06\00\00\00\01\00\00\00\1F\00\00\00" }>, align 4

; probe6::probe
; Function Attrs: nounwind
define dso_local void @_ZN6probe65probe17h15c2c49f41bb4300E() unnamed_addr #0 {
start:
  ret void
}

; core::panicking::panic_const::panic_const_div_by_zero
; Function Attrs: cold noinline noreturn nounwind
declare dso_local void @_ZN4core9panicking11panic_const23panic_const_div_by_zero17h2ca029bd5ff982f0E(ptr align 4) unnamed_addr #1

attributes #0 = { nounwind "target-cpu"="generic" }
attributes #1 = { cold noinline noreturn nounwind "target-cpu"="generic" }

!llvm.ident = !{!0}

!0 = !{!"rustc version 1.92.0 (ded5c06cf 2025-12-08)"}
