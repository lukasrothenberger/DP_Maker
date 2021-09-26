; ModuleID = 'polybench.c'
source_filename = "polybench.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@polybench_papi_counters_threadid = dso_local global i32 0, align 4, !dbg !0
@polybench_program_total_flops = dso_local global double 0.000000e+00, align 8, !dbg !10
@.str = private unnamed_addr constant [12 x i8] c"tmp <= 10.0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"polybench.c\00", align 1
@__PRETTY_FUNCTION__.polybench_flush_cache = private unnamed_addr constant [29 x i8] c"void polybench_flush_cache()\00", align 1
@polybench_t_start = common dso_local global double 0.000000e+00, align 8, !dbg !12
@polybench_t_end = common dso_local global double 0.000000e+00, align 8, !dbg !14
@.str.2 = private unnamed_addr constant [7 x i8] c"%0.6f\0A\00", align 1
@polybench_c_start = common dso_local global i64 0, align 8, !dbg !16
@polybench_c_end = common dso_local global i64 0, align 8, !dbg !19
@polybench_inter_array_padding_sz = internal global i64 0, align 8, !dbg !21
@stderr = external dso_local global %struct._IO_FILE*, align 8
@.str.3 = private unnamed_addr constant [51 x i8] c"[PolyBench] posix_memalign: cannot allocate memory\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"cs\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"flush\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"tmp\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"i\00", align 1
@.str.8 = private unnamed_addr constant [18 x i8] c"polybench_t_start\00", align 1
@.str.9 = private unnamed_addr constant [16 x i8] c"polybench_t_end\00", align 1
@.str.10 = private unnamed_addr constant [9 x i8] c"ptr.addr\00", align 1
@.str.11 = private unnamed_addr constant [7 x i8] c"n.addr\00", align 1
@.str.12 = private unnamed_addr constant [4 x i8] c"val\00", align 1
@.str.13 = private unnamed_addr constant [14 x i8] c"elt_size.addr\00", align 1
@.str.14 = private unnamed_addr constant [4 x i8] c"ret\00", align 1
@.str.15 = private unnamed_addr constant [33 x i8] c"polybench_inter_array_padding_sz\00", align 1
@.str.16 = private unnamed_addr constant [14 x i8] c"alloc_sz.addr\00", align 1
@.str.17 = private unnamed_addr constant [10 x i8] c"padded_sz\00", align 1
@.str.18 = private unnamed_addr constant [4 x i8] c"err\00", align 1
@.str.19 = private unnamed_addr constant [7 x i8] c"stderr\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @polybench_flush_cache() #0 !dbg !31 {
entry:
  call void @__dp_func_entry(i32 49266, i32 0)
  %cs = alloca i32, align 4
  %flush = alloca double*, align 8
  %i = alloca i32, align 4
  %tmp = alloca double, align 8
  call void @llvm.dbg.declare(metadata i32* %cs, metadata !34, metadata !DIExpression()), !dbg !35
  %0 = ptrtoint i32* %cs to i64
  call void @__dp_write(i32 49266, i64 %0, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0))
  store i32 4194560, i32* %cs, align 4, !dbg !35
  call void @llvm.dbg.declare(metadata double** %flush, metadata !36, metadata !DIExpression()), !dbg !37
  %1 = ptrtoint i32* %cs to i64
  call void @__dp_read(i32 49267, i64 %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0))
  %2 = load i32, i32* %cs, align 4, !dbg !38
  %conv = sext i32 %2 to i64, !dbg !38
  call void @__dp_call(i32 49267), !dbg !39
  %call = call noalias i8* @calloc(i64 %conv, i64 8) #5, !dbg !39
  %3 = bitcast i8* %call to double*, !dbg !40
  %4 = ptrtoint double** %flush to i64
  call void @__dp_write(i32 49267, i64 %4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i32 0, i32 0))
  store double* %3, double** %flush, align 8, !dbg !37
  call void @llvm.dbg.declare(metadata i32* %i, metadata !41, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.declare(metadata double* %tmp, metadata !43, metadata !DIExpression()), !dbg !44
  %5 = ptrtoint double* %tmp to i64
  call void @__dp_write(i32 49269, i64 %5, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  store double 0.000000e+00, double* %tmp, align 8, !dbg !44
  %6 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 49273, i64 %6, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  store i32 0, i32* %i, align 4, !dbg !45
  br label %for.cond, !dbg !47

for.cond:                                         ; preds = %for.inc, %entry
  call void @__dp_loop_entry(i32 49273, i32 0)
  %7 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 49273, i64 %7, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  %8 = load i32, i32* %i, align 4, !dbg !48
  %9 = ptrtoint i32* %cs to i64
  call void @__dp_read(i32 49273, i64 %9, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0))
  %10 = load i32, i32* %cs, align 4, !dbg !50
  %cmp = icmp slt i32 %8, %10, !dbg !51
  br i1 %cmp, label %for.body, label %for.end, !dbg !52

for.body:                                         ; preds = %for.cond
  %11 = ptrtoint double** %flush to i64
  call void @__dp_read(i32 49274, i64 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i32 0, i32 0))
  %12 = load double*, double** %flush, align 8, !dbg !53
  %13 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 49274, i64 %13, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  %14 = load i32, i32* %i, align 4, !dbg !54
  %idxprom = sext i32 %14 to i64, !dbg !53
  %arrayidx = getelementptr inbounds double, double* %12, i64 %idxprom, !dbg !53
  %15 = ptrtoint double* %arrayidx to i64
  call void @__dp_read(i32 49274, i64 %15, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i32 0, i32 0))
  %16 = load double, double* %arrayidx, align 8, !dbg !53
  %17 = ptrtoint double* %tmp to i64
  call void @__dp_read(i32 49274, i64 %17, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  %18 = load double, double* %tmp, align 8, !dbg !55
  %add = fadd double %18, %16, !dbg !55
  %19 = ptrtoint double* %tmp to i64
  call void @__dp_write(i32 49274, i64 %19, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  store double %add, double* %tmp, align 8, !dbg !55
  br label %for.inc, !dbg !56

for.inc:                                          ; preds = %for.body
  %20 = ptrtoint i32* %i to i64
  call void @__dp_read(i32 49273, i64 %20, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  %21 = load i32, i32* %i, align 4, !dbg !57
  %inc = add nsw i32 %21, 1, !dbg !57
  %22 = ptrtoint i32* %i to i64
  call void @__dp_write(i32 49273, i64 %22, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i32 0, i32 0))
  store i32 %inc, i32* %i, align 4, !dbg !57
  br label %for.cond, !dbg !58, !llvm.loop !59

for.end:                                          ; preds = %for.cond
  call void @__dp_loop_exit(i32 49275, i32 0)
  %23 = ptrtoint double* %tmp to i64
  call void @__dp_read(i32 49275, i64 %23, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i32 0, i32 0))
  %24 = load double, double* %tmp, align 8, !dbg !61
  %cmp2 = fcmp ole double %24, 1.000000e+01, !dbg !61
  br i1 %cmp2, label %if.then, label %if.else, !dbg !64

if.then:                                          ; preds = %for.end
  br label %if.end, !dbg !64

if.else:                                          ; preds = %for.end
  call void @__dp_finalize(i32 49275), !dbg !61
  call void @__assert_fail(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0), i32 123, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__PRETTY_FUNCTION__.polybench_flush_cache, i32 0, i32 0)) #6, !dbg !61
  unreachable, !dbg !61

if.end:                                           ; preds = %if.then
  %25 = ptrtoint double** %flush to i64
  call void @__dp_read(i32 49276, i64 %25, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i32 0, i32 0))
  %26 = load double*, double** %flush, align 8, !dbg !65
  %27 = bitcast double* %26 to i8*, !dbg !65
  call void @__dp_call(i32 49276), !dbg !66
  call void @free(i8* %27) #5, !dbg !66
  call void @__dp_func_exit(i32 49277, i32 0), !dbg !67
  ret void, !dbg !67
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @calloc(i64, i64) #2

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #3

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @polybench_prepare_instruments() #0 !dbg !68 {
entry:
  call void @__dp_func_entry(i32 49508, i32 0), !dbg !69
  call void @__dp_call(i32 49508), !dbg !69
  call void @polybench_flush_cache(), !dbg !69
  call void @__dp_func_exit(i32 49513, i32 0), !dbg !70
  ret void, !dbg !70
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @polybench_timer_start() #0 !dbg !71 {
entry:
  call void @__dp_func_entry(i32 49518, i32 0), !dbg !72
  call void @__dp_call(i32 49518), !dbg !72
  call void @polybench_prepare_instruments(), !dbg !72
  call void @__dp_call(i32 49520), !dbg !73
  %call = call double @rtclock(), !dbg !73
  %0 = ptrtoint double* @polybench_t_start to i64
  call void @__dp_write(i32 49520, i64 %0, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i32 0, i32 0))
  store double %call, double* @polybench_t_start, align 8, !dbg !74
  call void @__dp_func_exit(i32 49524, i32 0), !dbg !75
  ret void, !dbg !75
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @polybench_timer_stop() #0 !dbg !76 {
entry:
  call void @__dp_func_entry(i32 49530, i32 0), !dbg !77
  call void @__dp_call(i32 49530), !dbg !77
  %call = call double @rtclock(), !dbg !77
  %0 = ptrtoint double* @polybench_t_end to i64
  call void @__dp_write(i32 49530, i64 %0, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.9, i32 0, i32 0))
  store double %call, double* @polybench_t_end, align 8, !dbg !78
  call void @__dp_func_exit(i32 49537, i32 0), !dbg !79
  ret void, !dbg !79
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @polybench_timer_print() #0 !dbg !80 {
entry:
  call void @__dp_func_entry(i32 49554, i32 0), !dbg !81
  %0 = ptrtoint double* @polybench_t_end to i64
  call void @__dp_read(i32 49554, i64 %0, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.9, i32 0, i32 0))
  %1 = load double, double* @polybench_t_end, align 8, !dbg !81
  %2 = ptrtoint double* @polybench_t_start to i64
  call void @__dp_read(i32 49554, i64 %2, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i32 0, i32 0))
  %3 = load double, double* @polybench_t_start, align 8, !dbg !82
  %sub = fsub double %1, %3, !dbg !83
  call void @__dp_call(i32 49554), !dbg !84
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0), double %sub), !dbg !84
  call void @__dp_func_exit(i32 49559, i32 0), !dbg !85
  ret void, !dbg !85
}

declare dso_local i32 @printf(i8*, ...) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @polybench_free_data(i8* %ptr) #0 !dbg !86 {
entry:
  call void @__dp_func_entry(i32 49699, i32 0)
  %ptr.addr = alloca i8*, align 8
  store i8* %ptr, i8** %ptr.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %ptr.addr, metadata !89, metadata !DIExpression()), !dbg !90
  %0 = ptrtoint i8** %ptr.addr to i64
  call void @__dp_read(i32 49704, i64 %0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.10, i32 0, i32 0))
  %1 = load i8*, i8** %ptr.addr, align 8, !dbg !91
  call void @__dp_call(i32 49704), !dbg !92
  call void @free(i8* %1) #5, !dbg !92
  call void @__dp_func_exit(i32 49706, i32 0), !dbg !93
  ret void, !dbg !93
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @polybench_alloc_data(i64 %n, i32 %elt_size) #0 !dbg !94 {
entry:
  call void @__dp_func_entry(i32 49709, i32 0)
  %n.addr = alloca i64, align 8
  %elt_size.addr = alloca i32, align 4
  %val = alloca i64, align 8
  %ret = alloca i8*, align 8
  store i64 %n, i64* %n.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %n.addr, metadata !97, metadata !DIExpression()), !dbg !98
  store i32 %elt_size, i32* %elt_size.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %elt_size.addr, metadata !99, metadata !DIExpression()), !dbg !100
  call void @llvm.dbg.declare(metadata i64* %val, metadata !101, metadata !DIExpression()), !dbg !102
  %0 = ptrtoint i64* %n.addr to i64
  call void @__dp_read(i32 49716, i64 %0, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.11, i32 0, i32 0))
  %1 = load i64, i64* %n.addr, align 8, !dbg !103
  %2 = ptrtoint i64* %val to i64
  call void @__dp_write(i32 49716, i64 %2, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12, i32 0, i32 0))
  store i64 %1, i64* %val, align 8, !dbg !102
  %3 = ptrtoint i32* %elt_size.addr to i64
  call void @__dp_read(i32 49717, i64 %3, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.13, i32 0, i32 0))
  %4 = load i32, i32* %elt_size.addr, align 4, !dbg !104
  %conv = sext i32 %4 to i64, !dbg !104
  %5 = ptrtoint i64* %val to i64
  call void @__dp_read(i32 49717, i64 %5, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12, i32 0, i32 0))
  %6 = load i64, i64* %val, align 8, !dbg !105
  %mul = mul i64 %6, %conv, !dbg !105
  %7 = ptrtoint i64* %val to i64
  call void @__dp_write(i32 49717, i64 %7, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12, i32 0, i32 0))
  store i64 %mul, i64* %val, align 8, !dbg !105
  call void @llvm.dbg.declare(metadata i8** %ret, metadata !106, metadata !DIExpression()), !dbg !107
  %8 = ptrtoint i64* %val to i64
  call void @__dp_read(i32 49718, i64 %8, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12, i32 0, i32 0))
  %9 = load i64, i64* %val, align 8, !dbg !108
  call void @__dp_call(i32 49718), !dbg !109
  %call = call i8* @xmalloc(i64 %9), !dbg !109
  %10 = ptrtoint i8** %ret to i64
  call void @__dp_write(i32 49718, i64 %10, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.14, i32 0, i32 0))
  store i8* %call, i8** %ret, align 8, !dbg !107
  %11 = ptrtoint i8** %ret to i64
  call void @__dp_read(i32 49720, i64 %11, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.14, i32 0, i32 0))
  %12 = load i8*, i8** %ret, align 8, !dbg !110
  call void @__dp_func_exit(i32 49720, i32 0), !dbg !111
  ret i8* %12, !dbg !111
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i8* @xmalloc(i64 %alloc_sz) #0 !dbg !112 {
entry:
  call void @__dp_func_entry(i32 49669, i32 0)
  %alloc_sz.addr = alloca i64, align 8
  %ret = alloca i8*, align 8
  %padded_sz = alloca i64, align 8
  %err = alloca i32, align 4
  store i64 %alloc_sz, i64* %alloc_sz.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %alloc_sz.addr, metadata !115, metadata !DIExpression()), !dbg !116
  call void @llvm.dbg.declare(metadata i8** %ret, metadata !117, metadata !DIExpression()), !dbg !118
  %0 = ptrtoint i8** %ret to i64
  call void @__dp_write(i32 49671, i64 %0, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.14, i32 0, i32 0))
  store i8* null, i8** %ret, align 8, !dbg !118
  %1 = ptrtoint i64* @polybench_inter_array_padding_sz to i64
  call void @__dp_read(i32 49673, i64 %1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.15, i32 0, i32 0))
  %2 = load i64, i64* @polybench_inter_array_padding_sz, align 8, !dbg !119
  %add = add i64 %2, 0, !dbg !119
  %3 = ptrtoint i64* @polybench_inter_array_padding_sz to i64
  call void @__dp_write(i32 49673, i64 %3, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.15, i32 0, i32 0))
  store i64 %add, i64* @polybench_inter_array_padding_sz, align 8, !dbg !119
  call void @llvm.dbg.declare(metadata i64* %padded_sz, metadata !120, metadata !DIExpression()), !dbg !121
  %4 = ptrtoint i64* %alloc_sz.addr to i64
  call void @__dp_read(i32 49674, i64 %4, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.16, i32 0, i32 0))
  %5 = load i64, i64* %alloc_sz.addr, align 8, !dbg !122
  %6 = ptrtoint i64* @polybench_inter_array_padding_sz to i64
  call void @__dp_read(i32 49674, i64 %6, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.15, i32 0, i32 0))
  %7 = load i64, i64* @polybench_inter_array_padding_sz, align 8, !dbg !123
  %add1 = add i64 %5, %7, !dbg !124
  %8 = ptrtoint i64* %padded_sz to i64
  call void @__dp_write(i32 49674, i64 %8, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.17, i32 0, i32 0))
  store i64 %add1, i64* %padded_sz, align 8, !dbg !121
  call void @llvm.dbg.declare(metadata i32* %err, metadata !125, metadata !DIExpression()), !dbg !126
  %9 = ptrtoint i64* %padded_sz to i64
  call void @__dp_read(i32 49675, i64 %9, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.17, i32 0, i32 0))
  %10 = load i64, i64* %padded_sz, align 8, !dbg !127
  call void @__dp_call(i32 49675), !dbg !128
  %call = call i32 @posix_memalign(i8** %ret, i64 4096, i64 %10) #5, !dbg !128
  %11 = ptrtoint i32* %err to i64
  call void @__dp_write(i32 49675, i64 %11, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.18, i32 0, i32 0))
  store i32 %call, i32* %err, align 4, !dbg !126
  %12 = ptrtoint i8** %ret to i64
  call void @__dp_read(i32 49676, i64 %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.14, i32 0, i32 0))
  %13 = load i8*, i8** %ret, align 8, !dbg !129
  %tobool = icmp ne i8* %13, null, !dbg !129
  br i1 %tobool, label %lor.lhs.false, label %if.then, !dbg !131

lor.lhs.false:                                    ; preds = %entry
  %14 = ptrtoint i32* %err to i64
  call void @__dp_read(i32 49676, i64 %14, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.18, i32 0, i32 0))
  %15 = load i32, i32* %err, align 4, !dbg !132
  %tobool2 = icmp ne i32 %15, 0, !dbg !132
  br i1 %tobool2, label %if.then, label %if.end, !dbg !133

if.then:                                          ; preds = %lor.lhs.false, %entry
  %16 = ptrtoint %struct._IO_FILE** @stderr to i64
  call void @__dp_read(i32 49678, i64 %16, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.19, i32 0, i32 0))
  %17 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !134
  call void @__dp_call(i32 49678), !dbg !136
  %call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %17, i8* getelementptr inbounds ([51 x i8], [51 x i8]* @.str.3, i32 0, i32 0)), !dbg !136
  call void @__dp_finalize(i32 49679), !dbg !137
  call void @exit(i32 1) #6, !dbg !137
  unreachable, !dbg !137

if.end:                                           ; preds = %lor.lhs.false
  %18 = ptrtoint i8** %ret to i64
  call void @__dp_read(i32 49695, i64 %18, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.14, i32 0, i32 0))
  %19 = load i8*, i8** %ret, align 8, !dbg !138
  call void @__dp_func_exit(i32 49695, i32 0), !dbg !139
  ret i8* %19, !dbg !139
}

; Function Attrs: noinline nounwind optnone uwtable
define internal double @rtclock() #0 !dbg !140 {
entry:
  call void @__dp_func_entry(i32 49245, i32 0), !dbg !143
  call void @__dp_func_exit(i32 49245, i32 0), !dbg !143
  ret double 0.000000e+00, !dbg !143
}

; Function Attrs: nounwind
declare dso_local i32 @posix_memalign(i8**, i64, i64) #2

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #4

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #3

declare void @__dp_init(i32, i32, i32)

declare void @__dp_finalize(i32)

declare void @__dp_read(i32, i64, i8*)

declare void @__dp_write(i32, i64, i8*)

declare void @__dp_call(i32)

declare void @__dp_func_entry(i32, i32)

declare void @__dp_func_exit(i32, i32)

declare void @__dp_loop_entry(i32, i32)

declare void @__dp_loop_exit(i32, i32)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!27, !28, !29}
!llvm.ident = !{!30}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "polybench_papi_counters_threadid", scope: !2, file: !3, line: 45, type: !26, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.1-9 (tags/RELEASE_801/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !9, nameTableKind: None)
!3 = !DIFile(filename: "polybench.c", directory: "/home/lukas/git/DP_Maker/atax_Makefile")
!4 = !{}
!5 = !{!6, !8}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!9 = !{!0, !10, !12, !14, !16, !19, !21}
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "polybench_program_total_flops", scope: !2, file: !3, line: 46, type: !7, isLocal: false, isDefinition: true)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "polybench_t_start", scope: !2, file: !3, line: 78, type: !7, isLocal: false, isDefinition: true)
!14 = !DIGlobalVariableExpression(var: !15, expr: !DIExpression())
!15 = distinct !DIGlobalVariable(name: "polybench_t_end", scope: !2, file: !3, line: 78, type: !7, isLocal: false, isDefinition: true)
!16 = !DIGlobalVariableExpression(var: !17, expr: !DIExpression())
!17 = distinct !DIGlobalVariable(name: "polybench_c_start", scope: !2, file: !3, line: 80, type: !18, isLocal: false, isDefinition: true)
!18 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!19 = !DIGlobalVariableExpression(var: !20, expr: !DIExpression())
!20 = distinct !DIGlobalVariable(name: "polybench_c_end", scope: !2, file: !3, line: 80, type: !18, isLocal: false, isDefinition: true)
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "polybench_inter_array_padding_sz", scope: !2, file: !3, line: 75, type: !23, isLocal: true, isDefinition: true)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !24, line: 62, baseType: !25)
!24 = !DIFile(filename: "/usr/lib/clang/8.0.1/include/stddef.h", directory: "")
!25 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!26 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!27 = !{i32 2, !"Dwarf Version", i32 4}
!28 = !{i32 2, !"Debug Info Version", i32 3}
!29 = !{i32 1, !"wchar_size", i32 4}
!30 = !{!"clang version 8.0.1-9 (tags/RELEASE_801/final)"}
!31 = distinct !DISubprogram(name: "polybench_flush_cache", scope: !3, file: !3, line: 112, type: !32, scopeLine: 113, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!32 = !DISubroutineType(types: !33)
!33 = !{null}
!34 = !DILocalVariable(name: "cs", scope: !31, file: !3, line: 114, type: !26)
!35 = !DILocation(line: 114, column: 7, scope: !31)
!36 = !DILocalVariable(name: "flush", scope: !31, file: !3, line: 115, type: !6)
!37 = !DILocation(line: 115, column: 11, scope: !31)
!38 = !DILocation(line: 115, column: 37, scope: !31)
!39 = !DILocation(line: 115, column: 29, scope: !31)
!40 = !DILocation(line: 115, column: 19, scope: !31)
!41 = !DILocalVariable(name: "i", scope: !31, file: !3, line: 116, type: !26)
!42 = !DILocation(line: 116, column: 7, scope: !31)
!43 = !DILocalVariable(name: "tmp", scope: !31, file: !3, line: 117, type: !7)
!44 = !DILocation(line: 117, column: 10, scope: !31)
!45 = !DILocation(line: 121, column: 10, scope: !46)
!46 = distinct !DILexicalBlock(scope: !31, file: !3, line: 121, column: 3)
!47 = !DILocation(line: 121, column: 8, scope: !46)
!48 = !DILocation(line: 121, column: 15, scope: !49)
!49 = distinct !DILexicalBlock(scope: !46, file: !3, line: 121, column: 3)
!50 = !DILocation(line: 121, column: 19, scope: !49)
!51 = !DILocation(line: 121, column: 17, scope: !49)
!52 = !DILocation(line: 121, column: 3, scope: !46)
!53 = !DILocation(line: 122, column: 12, scope: !49)
!54 = !DILocation(line: 122, column: 18, scope: !49)
!55 = !DILocation(line: 122, column: 9, scope: !49)
!56 = !DILocation(line: 122, column: 5, scope: !49)
!57 = !DILocation(line: 121, column: 24, scope: !49)
!58 = !DILocation(line: 121, column: 3, scope: !49)
!59 = distinct !{!59, !52, !60}
!60 = !DILocation(line: 122, column: 19, scope: !46)
!61 = !DILocation(line: 123, column: 3, scope: !62)
!62 = distinct !DILexicalBlock(scope: !63, file: !3, line: 123, column: 3)
!63 = distinct !DILexicalBlock(scope: !31, file: !3, line: 123, column: 3)
!64 = !DILocation(line: 123, column: 3, scope: !63)
!65 = !DILocation(line: 124, column: 9, scope: !31)
!66 = !DILocation(line: 124, column: 3, scope: !31)
!67 = !DILocation(line: 125, column: 1, scope: !31)
!68 = distinct !DISubprogram(name: "polybench_prepare_instruments", scope: !3, file: !3, line: 353, type: !32, scopeLine: 354, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!69 = !DILocation(line: 356, column: 3, scope: !68)
!70 = !DILocation(line: 361, column: 1, scope: !68)
!71 = distinct !DISubprogram(name: "polybench_timer_start", scope: !3, file: !3, line: 364, type: !32, scopeLine: 365, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!72 = !DILocation(line: 366, column: 3, scope: !71)
!73 = !DILocation(line: 368, column: 23, scope: !71)
!74 = !DILocation(line: 368, column: 21, scope: !71)
!75 = !DILocation(line: 372, column: 1, scope: !71)
!76 = distinct !DISubprogram(name: "polybench_timer_stop", scope: !3, file: !3, line: 375, type: !32, scopeLine: 376, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!77 = !DILocation(line: 378, column: 21, scope: !76)
!78 = !DILocation(line: 378, column: 19, scope: !76)
!79 = !DILocation(line: 385, column: 1, scope: !76)
!80 = distinct !DISubprogram(name: "polybench_timer_print", scope: !3, file: !3, line: 388, type: !32, scopeLine: 389, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!81 = !DILocation(line: 402, column: 26, scope: !80)
!82 = !DILocation(line: 402, column: 44, scope: !80)
!83 = !DILocation(line: 402, column: 42, scope: !80)
!84 = !DILocation(line: 402, column: 7, scope: !80)
!85 = !DILocation(line: 407, column: 1, scope: !80)
!86 = distinct !DISubprogram(name: "polybench_free_data", scope: !3, file: !3, line: 547, type: !87, scopeLine: 548, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!87 = !DISubroutineType(types: !88)
!88 = !{null, !8}
!89 = !DILocalVariable(name: "ptr", arg: 1, scope: !86, file: !3, line: 547, type: !8)
!90 = !DILocation(line: 547, column: 32, scope: !86)
!91 = !DILocation(line: 552, column: 9, scope: !86)
!92 = !DILocation(line: 552, column: 3, scope: !86)
!93 = !DILocation(line: 554, column: 1, scope: !86)
!94 = distinct !DISubprogram(name: "polybench_alloc_data", scope: !3, file: !3, line: 557, type: !95, scopeLine: 558, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!95 = !DISubroutineType(types: !96)
!96 = !{!8, !18, !26}
!97 = !DILocalVariable(name: "n", arg: 1, scope: !94, file: !3, line: 557, type: !18)
!98 = !DILocation(line: 557, column: 51, scope: !94)
!99 = !DILocalVariable(name: "elt_size", arg: 2, scope: !94, file: !3, line: 557, type: !26)
!100 = !DILocation(line: 557, column: 58, scope: !94)
!101 = !DILocalVariable(name: "val", scope: !94, file: !3, line: 564, type: !23)
!102 = !DILocation(line: 564, column: 10, scope: !94)
!103 = !DILocation(line: 564, column: 16, scope: !94)
!104 = !DILocation(line: 565, column: 10, scope: !94)
!105 = !DILocation(line: 565, column: 7, scope: !94)
!106 = !DILocalVariable(name: "ret", scope: !94, file: !3, line: 566, type: !8)
!107 = !DILocation(line: 566, column: 9, scope: !94)
!108 = !DILocation(line: 566, column: 24, scope: !94)
!109 = !DILocation(line: 566, column: 15, scope: !94)
!110 = !DILocation(line: 568, column: 10, scope: !94)
!111 = !DILocation(line: 568, column: 3, scope: !94)
!112 = distinct !DISubprogram(name: "xmalloc", scope: !3, file: !3, line: 517, type: !113, scopeLine: 518, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!113 = !DISubroutineType(types: !114)
!114 = !{!8, !23}
!115 = !DILocalVariable(name: "alloc_sz", arg: 1, scope: !112, file: !3, line: 517, type: !23)
!116 = !DILocation(line: 517, column: 16, scope: !112)
!117 = !DILocalVariable(name: "ret", scope: !112, file: !3, line: 519, type: !8)
!118 = !DILocation(line: 519, column: 9, scope: !112)
!119 = !DILocation(line: 521, column: 36, scope: !112)
!120 = !DILocalVariable(name: "padded_sz", scope: !112, file: !3, line: 522, type: !23)
!121 = !DILocation(line: 522, column: 10, scope: !112)
!122 = !DILocation(line: 522, column: 22, scope: !112)
!123 = !DILocation(line: 522, column: 33, scope: !112)
!124 = !DILocation(line: 522, column: 31, scope: !112)
!125 = !DILocalVariable(name: "err", scope: !112, file: !3, line: 523, type: !26)
!126 = !DILocation(line: 523, column: 7, scope: !112)
!127 = !DILocation(line: 523, column: 41, scope: !112)
!128 = !DILocation(line: 523, column: 13, scope: !112)
!129 = !DILocation(line: 524, column: 9, scope: !130)
!130 = distinct !DILexicalBlock(scope: !112, file: !3, line: 524, column: 7)
!131 = !DILocation(line: 524, column: 13, scope: !130)
!132 = !DILocation(line: 524, column: 16, scope: !130)
!133 = !DILocation(line: 524, column: 7, scope: !112)
!134 = !DILocation(line: 526, column: 16, scope: !135)
!135 = distinct !DILexicalBlock(scope: !130, file: !3, line: 525, column: 5)
!136 = !DILocation(line: 526, column: 7, scope: !135)
!137 = !DILocation(line: 527, column: 7, scope: !135)
!138 = !DILocation(line: 543, column: 10, scope: !112)
!139 = !DILocation(line: 543, column: 3, scope: !112)
!140 = distinct !DISubprogram(name: "rtclock", scope: !3, file: !3, line: 83, type: !141, scopeLine: 84, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!141 = !DISubroutineType(types: !142)
!142 = !{!7}
!143 = !DILocation(line: 93, column: 5, scope: !140)
