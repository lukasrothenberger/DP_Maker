; ModuleID = 'atax.c'
source_filename = "atax.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external dso_local global %struct._IO_FILE*, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"y\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 !dbg !21 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %m = alloca i32, align 4
  %n = alloca i32, align 4
  %A = alloca [1900 x [2100 x double]]*, align 8
  %x = alloca [2100 x double]*, align 8
  %y = alloca [2100 x double]*, align 8
  %tmp = alloca [1900 x double]*, align 8
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !28, metadata !DIExpression()), !dbg !29
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %m, metadata !32, metadata !DIExpression()), !dbg !33
  store i32 1900, i32* %m, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata i32* %n, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 2100, i32* %n, align 4, !dbg !35
  call void @llvm.dbg.declare(metadata [1900 x [2100 x double]]** %A, metadata !36, metadata !DIExpression()), !dbg !37
  %call = call i8* @polybench_alloc_data(i64 3990000, i32 8), !dbg !37
  %0 = bitcast i8* %call to [1900 x [2100 x double]]*, !dbg !37
  store [1900 x [2100 x double]]* %0, [1900 x [2100 x double]]** %A, align 8, !dbg !37
  call void @llvm.dbg.declare(metadata [2100 x double]** %x, metadata !38, metadata !DIExpression()), !dbg !39
  %call1 = call i8* @polybench_alloc_data(i64 2100, i32 8), !dbg !39
  %1 = bitcast i8* %call1 to [2100 x double]*, !dbg !39
  store [2100 x double]* %1, [2100 x double]** %x, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata [2100 x double]** %y, metadata !40, metadata !DIExpression()), !dbg !41
  %call2 = call i8* @polybench_alloc_data(i64 2100, i32 8), !dbg !41
  %2 = bitcast i8* %call2 to [2100 x double]*, !dbg !41
  store [2100 x double]* %2, [2100 x double]** %y, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata [1900 x double]** %tmp, metadata !42, metadata !DIExpression()), !dbg !43
  %call3 = call i8* @polybench_alloc_data(i64 1900, i32 8), !dbg !43
  %3 = bitcast i8* %call3 to [1900 x double]*, !dbg !43
  store [1900 x double]* %3, [1900 x double]** %tmp, align 8, !dbg !43
  %4 = load i32, i32* %m, align 4, !dbg !44
  %5 = load i32, i32* %n, align 4, !dbg !45
  %6 = load [1900 x [2100 x double]]*, [1900 x [2100 x double]]** %A, align 8, !dbg !46
  %arraydecay = getelementptr inbounds [1900 x [2100 x double]], [1900 x [2100 x double]]* %6, i32 0, i32 0, !dbg !46
  %7 = load [2100 x double]*, [2100 x double]** %x, align 8, !dbg !47
  %arraydecay4 = getelementptr inbounds [2100 x double], [2100 x double]* %7, i32 0, i32 0, !dbg !47
  call void @init_array(i32 %4, i32 %5, [2100 x double]* %arraydecay, double* %arraydecay4), !dbg !48
  %8 = load i32, i32* %m, align 4, !dbg !49
  %9 = load i32, i32* %n, align 4, !dbg !50
  %10 = load [1900 x [2100 x double]]*, [1900 x [2100 x double]]** %A, align 8, !dbg !51
  %arraydecay5 = getelementptr inbounds [1900 x [2100 x double]], [1900 x [2100 x double]]* %10, i32 0, i32 0, !dbg !51
  %11 = load [2100 x double]*, [2100 x double]** %x, align 8, !dbg !52
  %arraydecay6 = getelementptr inbounds [2100 x double], [2100 x double]* %11, i32 0, i32 0, !dbg !52
  %12 = load [2100 x double]*, [2100 x double]** %y, align 8, !dbg !53
  %arraydecay7 = getelementptr inbounds [2100 x double], [2100 x double]* %12, i32 0, i32 0, !dbg !53
  %13 = load [1900 x double]*, [1900 x double]** %tmp, align 8, !dbg !54
  %arraydecay8 = getelementptr inbounds [1900 x double], [1900 x double]* %13, i32 0, i32 0, !dbg !54
  call void @kernel_atax(i32 %8, i32 %9, [2100 x double]* %arraydecay5, double* %arraydecay6, double* %arraydecay7, double* %arraydecay8), !dbg !55
  %14 = load i32, i32* %argc.addr, align 4, !dbg !56
  %cmp = icmp sgt i32 %14, 42, !dbg !56
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !56

land.lhs.true:                                    ; preds = %entry
  %15 = load i8**, i8*** %argv.addr, align 8, !dbg !56
  %arrayidx = getelementptr inbounds i8*, i8** %15, i64 0, !dbg !56
  %16 = load i8*, i8** %arrayidx, align 8, !dbg !56
  %call9 = call i32 @strcmp(i8* %16, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str, i32 0, i32 0)) #5, !dbg !56
  %tobool = icmp ne i32 %call9, 0, !dbg !56
  br i1 %tobool, label %if.end, label %if.then, !dbg !58

if.then:                                          ; preds = %land.lhs.true
  %17 = load i32, i32* %n, align 4, !dbg !56
  %18 = load [2100 x double]*, [2100 x double]** %y, align 8, !dbg !56
  %arraydecay10 = getelementptr inbounds [2100 x double], [2100 x double]* %18, i32 0, i32 0, !dbg !56
  call void @print_array(i32 %17, double* %arraydecay10), !dbg !56
  br label %if.end, !dbg !56

if.end:                                           ; preds = %if.then, %land.lhs.true, %entry
  %19 = load [1900 x [2100 x double]]*, [1900 x [2100 x double]]** %A, align 8, !dbg !59
  %20 = bitcast [1900 x [2100 x double]]* %19 to i8*, !dbg !59
  call void @free(i8* %20) #6, !dbg !59
  %21 = load [2100 x double]*, [2100 x double]** %x, align 8, !dbg !60
  %22 = bitcast [2100 x double]* %21 to i8*, !dbg !60
  call void @free(i8* %22) #6, !dbg !60
  %23 = load [2100 x double]*, [2100 x double]** %y, align 8, !dbg !61
  %24 = bitcast [2100 x double]* %23 to i8*, !dbg !61
  call void @free(i8* %24) #6, !dbg !61
  %25 = load [1900 x double]*, [1900 x double]** %tmp, align 8, !dbg !62
  %26 = bitcast [1900 x double]* %25 to i8*, !dbg !62
  call void @free(i8* %26) #6, !dbg !62
  call void @loop_counter_output(), !dbg !63
  ret i32 0, !dbg !63
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i8* @polybench_alloc_data(i64, i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 %m, i32 %n, [2100 x double]* %A, double* %x) #0 !dbg !64 {
entry:
  %m.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [2100 x double]*, align 8
  %x.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %fn = alloca double, align 8
  store i32 %m, i32* %m.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %m.addr, metadata !68, metadata !DIExpression()), !dbg !69
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !70, metadata !DIExpression()), !dbg !71
  store [2100 x double]* %A, [2100 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [2100 x double]** %A.addr, metadata !72, metadata !DIExpression()), !dbg !73
  store double* %x, double** %x.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x.addr, metadata !74, metadata !DIExpression()), !dbg !75
  call void @llvm.dbg.declare(metadata i32* %i, metadata !76, metadata !DIExpression()), !dbg !77
  call void @llvm.dbg.declare(metadata i32* %j, metadata !78, metadata !DIExpression()), !dbg !79
  call void @llvm.dbg.declare(metadata double* %fn, metadata !80, metadata !DIExpression()), !dbg !81
  %0 = load i32, i32* %n.addr, align 4, !dbg !82
  %conv = sitofp i32 %0 to double, !dbg !83
  store double %conv, double* %fn, align 8, !dbg !84
  store i32 0, i32* %i, align 4, !dbg !85
  br label %for.cond, !dbg !87

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !dbg !88
  %2 = load i32, i32* %n.addr, align 4, !dbg !90
  %cmp = icmp slt i32 %1, %2, !dbg !91
  br i1 %cmp, label %for.body, label %for.end, !dbg !92

for.body:                                         ; preds = %for.cond
  call void @incr_loop_counter(i32 3)
  %3 = load i32, i32* %i, align 4, !dbg !93
  %conv2 = sitofp i32 %3 to double, !dbg !93
  %4 = load double, double* %fn, align 8, !dbg !94
  %div = fdiv double %conv2, %4, !dbg !95
  %add = fadd double 1.000000e+00, %div, !dbg !96
  %5 = load double*, double** %x.addr, align 8, !dbg !97
  %6 = load i32, i32* %i, align 4, !dbg !98
  %idxprom = sext i32 %6 to i64, !dbg !97
  %arrayidx = getelementptr inbounds double, double* %5, i64 %idxprom, !dbg !97
  store double %add, double* %arrayidx, align 8, !dbg !99
  br label %for.inc, !dbg !97

for.inc:                                          ; preds = %for.body
  %7 = load i32, i32* %i, align 4, !dbg !100
  %inc = add nsw i32 %7, 1, !dbg !100
  store i32 %inc, i32* %i, align 4, !dbg !100
  br label %for.cond, !dbg !101, !llvm.loop !102

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !104
  br label %for.cond3, !dbg !106

for.cond3:                                        ; preds = %for.inc22, %for.end
  %8 = load i32, i32* %i, align 4, !dbg !107
  %9 = load i32, i32* %m.addr, align 4, !dbg !109
  %cmp4 = icmp slt i32 %8, %9, !dbg !110
  br i1 %cmp4, label %for.body6, label %for.end24, !dbg !111

for.body6:                                        ; preds = %for.cond3
  call void @incr_loop_counter(i32 1)
  store i32 0, i32* %j, align 4, !dbg !112
  br label %for.cond7, !dbg !114

for.cond7:                                        ; preds = %for.inc19, %for.body6
  %10 = load i32, i32* %j, align 4, !dbg !115
  %11 = load i32, i32* %n.addr, align 4, !dbg !117
  %cmp8 = icmp slt i32 %10, %11, !dbg !118
  br i1 %cmp8, label %for.body10, label %for.end21, !dbg !119

for.body10:                                       ; preds = %for.cond7
  call void @incr_loop_counter(i32 2)
  %12 = load i32, i32* %i, align 4, !dbg !120
  %13 = load i32, i32* %j, align 4, !dbg !121
  %add11 = add nsw i32 %12, %13, !dbg !122
  %14 = load i32, i32* %n.addr, align 4, !dbg !123
  %rem = srem i32 %add11, %14, !dbg !124
  %conv12 = sitofp i32 %rem to double, !dbg !125
  %15 = load i32, i32* %m.addr, align 4, !dbg !126
  %mul = mul nsw i32 5, %15, !dbg !127
  %conv13 = sitofp i32 %mul to double, !dbg !128
  %div14 = fdiv double %conv12, %conv13, !dbg !129
  %16 = load [2100 x double]*, [2100 x double]** %A.addr, align 8, !dbg !130
  %17 = load i32, i32* %i, align 4, !dbg !131
  %idxprom15 = sext i32 %17 to i64, !dbg !130
  %arrayidx16 = getelementptr inbounds [2100 x double], [2100 x double]* %16, i64 %idxprom15, !dbg !130
  %18 = load i32, i32* %j, align 4, !dbg !132
  %idxprom17 = sext i32 %18 to i64, !dbg !130
  %arrayidx18 = getelementptr inbounds [2100 x double], [2100 x double]* %arrayidx16, i64 0, i64 %idxprom17, !dbg !130
  store double %div14, double* %arrayidx18, align 8, !dbg !133
  br label %for.inc19, !dbg !130

for.inc19:                                        ; preds = %for.body10
  %19 = load i32, i32* %j, align 4, !dbg !134
  %inc20 = add nsw i32 %19, 1, !dbg !134
  store i32 %inc20, i32* %j, align 4, !dbg !134
  br label %for.cond7, !dbg !135, !llvm.loop !136

for.end21:                                        ; preds = %for.cond7
  br label %for.inc22, !dbg !137

for.inc22:                                        ; preds = %for.end21
  %20 = load i32, i32* %i, align 4, !dbg !138
  %inc23 = add nsw i32 %20, 1, !dbg !138
  store i32 %inc23, i32* %i, align 4, !dbg !138
  br label %for.cond3, !dbg !139, !llvm.loop !140

for.end24:                                        ; preds = %for.cond3
  ret void, !dbg !142
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @kernel_atax(i32 %m, i32 %n, [2100 x double]* %A, double* %x, double* %y, double* %tmp) #0 !dbg !143 {
entry:
  %m.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [2100 x double]*, align 8
  %x.addr = alloca double*, align 8
  %y.addr = alloca double*, align 8
  %tmp.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %m, i32* %m.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %m.addr, metadata !146, metadata !DIExpression()), !dbg !147
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !148, metadata !DIExpression()), !dbg !149
  store [2100 x double]* %A, [2100 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [2100 x double]** %A.addr, metadata !150, metadata !DIExpression()), !dbg !151
  store double* %x, double** %x.addr, align 8
  call void @llvm.dbg.declare(metadata double** %x.addr, metadata !152, metadata !DIExpression()), !dbg !153
  store double* %y, double** %y.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y.addr, metadata !154, metadata !DIExpression()), !dbg !155
  store double* %tmp, double** %tmp.addr, align 8
  call void @llvm.dbg.declare(metadata double** %tmp.addr, metadata !156, metadata !DIExpression()), !dbg !157
  call void @llvm.dbg.declare(metadata i32* %i, metadata !158, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.declare(metadata i32* %j, metadata !160, metadata !DIExpression()), !dbg !161
  store i32 0, i32* %i, align 4, !dbg !162
  br label %for.cond, !dbg !164

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !165
  %1 = load i32, i32* %n.addr, align 4, !dbg !167
  %cmp = icmp slt i32 %0, %1, !dbg !168
  br i1 %cmp, label %for.body, label %for.end, !dbg !169

for.body:                                         ; preds = %for.cond
  call void @incr_loop_counter(i32 7)
  %2 = load double*, double** %y.addr, align 8, !dbg !170
  %3 = load i32, i32* %i, align 4, !dbg !171
  %idxprom = sext i32 %3 to i64, !dbg !170
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom, !dbg !170
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !172
  br label %for.inc, !dbg !170

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !dbg !173
  %inc = add nsw i32 %4, 1, !dbg !173
  store i32 %inc, i32* %i, align 4, !dbg !173
  br label %for.cond, !dbg !174, !llvm.loop !175

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !177
  br label %for.cond1, !dbg !179

for.cond1:                                        ; preds = %for.inc40, %for.end
  %5 = load i32, i32* %i, align 4, !dbg !180
  %6 = load i32, i32* %m.addr, align 4, !dbg !182
  %cmp2 = icmp slt i32 %5, %6, !dbg !183
  br i1 %cmp2, label %for.body3, label %for.end42, !dbg !184

for.body3:                                        ; preds = %for.cond1
  call void @incr_loop_counter(i32 4)
  %7 = load double*, double** %tmp.addr, align 8, !dbg !185
  %8 = load i32, i32* %i, align 4, !dbg !187
  %idxprom4 = sext i32 %8 to i64, !dbg !185
  %arrayidx5 = getelementptr inbounds double, double* %7, i64 %idxprom4, !dbg !185
  store double 0.000000e+00, double* %arrayidx5, align 8, !dbg !188
  store i32 0, i32* %j, align 4, !dbg !189
  br label %for.cond6, !dbg !191

for.cond6:                                        ; preds = %for.inc19, %for.body3
  %9 = load i32, i32* %j, align 4, !dbg !192
  %10 = load i32, i32* %n.addr, align 4, !dbg !194
  %cmp7 = icmp slt i32 %9, %10, !dbg !195
  br i1 %cmp7, label %for.body8, label %for.end21, !dbg !196

for.body8:                                        ; preds = %for.cond6
  call void @incr_loop_counter(i32 5)
  %11 = load double*, double** %tmp.addr, align 8, !dbg !197
  %12 = load i32, i32* %i, align 4, !dbg !198
  %idxprom9 = sext i32 %12 to i64, !dbg !197
  %arrayidx10 = getelementptr inbounds double, double* %11, i64 %idxprom9, !dbg !197
  %13 = ptrtoint double* %arrayidx10 to i64
  call void @add_ptr_instr_rec(i32 79, i64 1, i32 0, i64 %13)
  %14 = load double, double* %arrayidx10, align 8, !dbg !197
  %15 = load [2100 x double]*, [2100 x double]** %A.addr, align 8, !dbg !199
  %16 = load i32, i32* %i, align 4, !dbg !200
  %idxprom11 = sext i32 %16 to i64, !dbg !199
  %arrayidx12 = getelementptr inbounds [2100 x double], [2100 x double]* %15, i64 %idxprom11, !dbg !199
  %17 = load i32, i32* %j, align 4, !dbg !201
  %idxprom13 = sext i32 %17 to i64, !dbg !199
  %arrayidx14 = getelementptr inbounds [2100 x double], [2100 x double]* %arrayidx12, i64 0, i64 %idxprom13, !dbg !199
  %18 = load double, double* %arrayidx14, align 8, !dbg !199
  %19 = load double*, double** %x.addr, align 8, !dbg !202
  %20 = load i32, i32* %j, align 4, !dbg !203
  %idxprom15 = sext i32 %20 to i64, !dbg !202
  %arrayidx16 = getelementptr inbounds double, double* %19, i64 %idxprom15, !dbg !202
  %21 = load double, double* %arrayidx16, align 8, !dbg !202
  %mul = fmul double %18, %21, !dbg !204
  %add = fadd double %14, %mul, !dbg !205
  %22 = load double*, double** %tmp.addr, align 8, !dbg !206
  %23 = load i32, i32* %i, align 4, !dbg !207
  %idxprom17 = sext i32 %23 to i64, !dbg !206
  %arrayidx18 = getelementptr inbounds double, double* %22, i64 %idxprom17, !dbg !206
  %24 = ptrtoint double* %arrayidx18 to i64
  call void @add_ptr_instr_rec(i32 79, i64 1, i32 1, i64 %24)
  store double %add, double* %arrayidx18, align 8, !dbg !208
  br label %for.inc19, !dbg !206

for.inc19:                                        ; preds = %for.body8
  %25 = load i32, i32* %j, align 4, !dbg !209
  %inc20 = add nsw i32 %25, 1, !dbg !209
  store i32 %inc20, i32* %j, align 4, !dbg !209
  br label %for.cond6, !dbg !210, !llvm.loop !211

for.end21:                                        ; preds = %for.cond6
  store i32 0, i32* %j, align 4, !dbg !213
  br label %for.cond22, !dbg !215

for.cond22:                                       ; preds = %for.inc37, %for.end21
  %26 = load i32, i32* %j, align 4, !dbg !216
  %27 = load i32, i32* %n.addr, align 4, !dbg !218
  %cmp23 = icmp slt i32 %26, %27, !dbg !219
  br i1 %cmp23, label %for.body24, label %for.end39, !dbg !220

for.body24:                                       ; preds = %for.cond22
  call void @incr_loop_counter(i32 6)
  %28 = load double*, double** %y.addr, align 8, !dbg !221
  %29 = load i32, i32* %j, align 4, !dbg !222
  %idxprom25 = sext i32 %29 to i64, !dbg !221
  %arrayidx26 = getelementptr inbounds double, double* %28, i64 %idxprom25, !dbg !221
  %30 = ptrtoint double* %arrayidx26 to i64
  call void @add_ptr_instr_rec(i32 81, i64 2, i32 0, i64 %30)
  %31 = ptrtoint double* %arrayidx26 to i64
  call void @add_ptr_instr_rec(i32 76, i64 3, i32 0, i64 %31)
  %32 = load double, double* %arrayidx26, align 8, !dbg !221
  %33 = load [2100 x double]*, [2100 x double]** %A.addr, align 8, !dbg !223
  %34 = load i32, i32* %i, align 4, !dbg !224
  %idxprom27 = sext i32 %34 to i64, !dbg !223
  %arrayidx28 = getelementptr inbounds [2100 x double], [2100 x double]* %33, i64 %idxprom27, !dbg !223
  %35 = load i32, i32* %j, align 4, !dbg !225
  %idxprom29 = sext i32 %35 to i64, !dbg !223
  %arrayidx30 = getelementptr inbounds [2100 x double], [2100 x double]* %arrayidx28, i64 0, i64 %idxprom29, !dbg !223
  %36 = load double, double* %arrayidx30, align 8, !dbg !223
  %37 = load double*, double** %tmp.addr, align 8, !dbg !226
  %38 = load i32, i32* %i, align 4, !dbg !227
  %idxprom31 = sext i32 %38 to i64, !dbg !226
  %arrayidx32 = getelementptr inbounds double, double* %37, i64 %idxprom31, !dbg !226
  %39 = load double, double* %arrayidx32, align 8, !dbg !226
  %mul33 = fmul double %36, %39, !dbg !228
  %add34 = fadd double %32, %mul33, !dbg !229
  %40 = load double*, double** %y.addr, align 8, !dbg !230
  %41 = load i32, i32* %j, align 4, !dbg !231
  %idxprom35 = sext i32 %41 to i64, !dbg !230
  %arrayidx36 = getelementptr inbounds double, double* %40, i64 %idxprom35, !dbg !230
  %42 = ptrtoint double* %arrayidx36 to i64
  call void @add_ptr_instr_rec(i32 81, i64 2, i32 1, i64 %42)
  %43 = ptrtoint double* %arrayidx36 to i64
  call void @add_ptr_instr_rec(i32 76, i64 3, i32 1, i64 %43)
  store double %add34, double* %arrayidx36, align 8, !dbg !232
  br label %for.inc37, !dbg !230

for.inc37:                                        ; preds = %for.body24
  %44 = load i32, i32* %j, align 4, !dbg !233
  %inc38 = add nsw i32 %44, 1, !dbg !233
  store i32 %inc38, i32* %j, align 4, !dbg !233
  br label %for.cond22, !dbg !234, !llvm.loop !235

for.end39:                                        ; preds = %for.cond22
  br label %for.inc40, !dbg !237

for.inc40:                                        ; preds = %for.end39
  %45 = load i32, i32* %i, align 4, !dbg !238
  %inc41 = add nsw i32 %45, 1, !dbg !238
  store i32 %inc41, i32* %i, align 4, !dbg !238
  br label %for.cond1, !dbg !239, !llvm.loop !240

for.end42:                                        ; preds = %for.cond1
  ret void, !dbg !242
}

; Function Attrs: nounwind readonly
declare dso_local i32 @strcmp(i8*, i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 %n, double* %y) #0 !dbg !243 {
entry:
  %n.addr = alloca i32, align 4
  %y.addr = alloca double*, align 8
  %i = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !246, metadata !DIExpression()), !dbg !247
  store double* %y, double** %y.addr, align 8
  call void @llvm.dbg.declare(metadata double** %y.addr, metadata !248, metadata !DIExpression()), !dbg !249
  call void @llvm.dbg.declare(metadata i32* %i, metadata !250, metadata !DIExpression()), !dbg !251
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !252
  %call = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0)), !dbg !252
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !253
  %call1 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %1, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0)), !dbg !253
  store i32 0, i32* %i, align 4, !dbg !254
  br label %for.cond, !dbg !256

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, i32* %i, align 4, !dbg !257
  %3 = load i32, i32* %n.addr, align 4, !dbg !259
  %cmp = icmp slt i32 %2, %3, !dbg !260
  br i1 %cmp, label %for.body, label %for.end, !dbg !261

for.body:                                         ; preds = %for.cond
  call void @incr_loop_counter(i32 8)
  %4 = load i32, i32* %i, align 4, !dbg !262
  %rem = srem i32 %4, 20, !dbg !265
  %cmp2 = icmp eq i32 %rem, 0, !dbg !266
  br i1 %cmp2, label %if.then, label %if.end, !dbg !267

if.then:                                          ; preds = %for.body
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !268
  %call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0)), !dbg !269
  br label %if.end, !dbg !269

if.end:                                           ; preds = %if.then, %for.body
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !270
  %7 = load double*, double** %y.addr, align 8, !dbg !271
  %8 = load i32, i32* %i, align 4, !dbg !272
  %idxprom = sext i32 %8 to i64, !dbg !271
  %arrayidx = getelementptr inbounds double, double* %7, i64 %idxprom, !dbg !271
  %9 = load double, double* %arrayidx, align 8, !dbg !271
  %call4 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %6, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.5, i32 0, i32 0), double %9), !dbg !273
  br label %for.inc, !dbg !274

for.inc:                                          ; preds = %if.end
  %10 = load i32, i32* %i, align 4, !dbg !275
  %inc = add nsw i32 %10, 1, !dbg !275
  store i32 %inc, i32* %i, align 4, !dbg !275
  br label %for.cond, !dbg !276, !llvm.loop !277

for.end:                                          ; preds = %for.cond
  %11 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !279
  %call5 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %11, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.6, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0)), !dbg !279
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !280
  %call6 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %12, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.7, i32 0, i32 0)), !dbg !280
  ret void, !dbg !281
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #2

declare void @add_instr_rec(i32, i64, i32)

declare void @add_ptr_instr_rec(i32, i64, i32, i64)

declare void @incr_loop_counter(i32)

declare void @loop_counter_output()

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!17, !18, !19}
!llvm.ident = !{!20}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.1-9 (tags/RELEASE_801/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, nameTableKind: None)
!1 = !DIFile(filename: "atax.c", directory: "/home/lukas/git/DP_Maker/atax_Makefile")
!2 = !{}
!3 = !{!4, !10, !13, !16, !6}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 255360000, elements: !7)
!6 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!7 = !{!8, !9}
!8 = !DISubrange(count: 1900)
!9 = !DISubrange(count: 2100)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 134400, elements: !12)
!12 = !{!9}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 121600, elements: !15)
!15 = !{!8}
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!17 = !{i32 2, !"Dwarf Version", i32 4}
!18 = !{i32 2, !"Debug Info Version", i32 3}
!19 = !{i32 1, !"wchar_size", i32 4}
!20 = !{!"clang version 8.0.1-9 (tags/RELEASE_801/final)"}
!21 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 89, type: !22, scopeLine: 90, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!22 = !DISubroutineType(types: !23)
!23 = !{!24, !24, !25}
!24 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!28 = !DILocalVariable(name: "argc", arg: 1, scope: !21, file: !1, line: 89, type: !24)
!29 = !DILocation(line: 89, column: 14, scope: !21)
!30 = !DILocalVariable(name: "argv", arg: 2, scope: !21, file: !1, line: 89, type: !25)
!31 = !DILocation(line: 89, column: 27, scope: !21)
!32 = !DILocalVariable(name: "m", scope: !21, file: !1, line: 92, type: !24)
!33 = !DILocation(line: 92, column: 7, scope: !21)
!34 = !DILocalVariable(name: "n", scope: !21, file: !1, line: 93, type: !24)
!35 = !DILocation(line: 93, column: 7, scope: !21)
!36 = !DILocalVariable(name: "A", scope: !21, file: !1, line: 96, type: !4)
!37 = !DILocation(line: 96, column: 3, scope: !21)
!38 = !DILocalVariable(name: "x", scope: !21, file: !1, line: 97, type: !10)
!39 = !DILocation(line: 97, column: 3, scope: !21)
!40 = !DILocalVariable(name: "y", scope: !21, file: !1, line: 98, type: !10)
!41 = !DILocation(line: 98, column: 3, scope: !21)
!42 = !DILocalVariable(name: "tmp", scope: !21, file: !1, line: 99, type: !13)
!43 = !DILocation(line: 99, column: 3, scope: !21)
!44 = !DILocation(line: 102, column: 15, scope: !21)
!45 = !DILocation(line: 102, column: 18, scope: !21)
!46 = !DILocation(line: 102, column: 21, scope: !21)
!47 = !DILocation(line: 102, column: 41, scope: !21)
!48 = !DILocation(line: 102, column: 3, scope: !21)
!49 = !DILocation(line: 108, column: 16, scope: !21)
!50 = !DILocation(line: 108, column: 19, scope: !21)
!51 = !DILocation(line: 109, column: 9, scope: !21)
!52 = !DILocation(line: 110, column: 9, scope: !21)
!53 = !DILocation(line: 111, column: 9, scope: !21)
!54 = !DILocation(line: 112, column: 9, scope: !21)
!55 = !DILocation(line: 108, column: 3, scope: !21)
!56 = !DILocation(line: 120, column: 3, scope: !57)
!57 = distinct !DILexicalBlock(scope: !21, file: !1, line: 120, column: 3)
!58 = !DILocation(line: 120, column: 3, scope: !21)
!59 = !DILocation(line: 123, column: 3, scope: !21)
!60 = !DILocation(line: 124, column: 3, scope: !21)
!61 = !DILocation(line: 125, column: 3, scope: !21)
!62 = !DILocation(line: 126, column: 3, scope: !21)
!63 = !DILocation(line: 128, column: 3, scope: !21)
!64 = distinct !DISubprogram(name: "init_array", scope: !1, file: !1, line: 26, type: !65, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!65 = !DISubroutineType(types: !66)
!66 = !{null, !24, !24, !10, !67}
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!68 = !DILocalVariable(name: "m", arg: 1, scope: !64, file: !1, line: 26, type: !24)
!69 = !DILocation(line: 26, column: 22, scope: !64)
!70 = !DILocalVariable(name: "n", arg: 2, scope: !64, file: !1, line: 26, type: !24)
!71 = !DILocation(line: 26, column: 29, scope: !64)
!72 = !DILocalVariable(name: "A", arg: 3, scope: !64, file: !1, line: 27, type: !10)
!73 = !DILocation(line: 27, column: 14, scope: !64)
!74 = !DILocalVariable(name: "x", arg: 4, scope: !64, file: !1, line: 28, type: !67)
!75 = !DILocation(line: 28, column: 14, scope: !64)
!76 = !DILocalVariable(name: "i", scope: !64, file: !1, line: 30, type: !24)
!77 = !DILocation(line: 30, column: 7, scope: !64)
!78 = !DILocalVariable(name: "j", scope: !64, file: !1, line: 30, type: !24)
!79 = !DILocation(line: 30, column: 10, scope: !64)
!80 = !DILocalVariable(name: "fn", scope: !64, file: !1, line: 31, type: !6)
!81 = !DILocation(line: 31, column: 13, scope: !64)
!82 = !DILocation(line: 32, column: 19, scope: !64)
!83 = !DILocation(line: 32, column: 8, scope: !64)
!84 = !DILocation(line: 32, column: 6, scope: !64)
!85 = !DILocation(line: 34, column: 10, scope: !86)
!86 = distinct !DILexicalBlock(scope: !64, file: !1, line: 34, column: 3)
!87 = !DILocation(line: 34, column: 8, scope: !86)
!88 = !DILocation(line: 34, column: 15, scope: !89)
!89 = distinct !DILexicalBlock(scope: !86, file: !1, line: 34, column: 3)
!90 = !DILocation(line: 34, column: 19, scope: !89)
!91 = !DILocation(line: 34, column: 17, scope: !89)
!92 = !DILocation(line: 34, column: 3, scope: !86)
!93 = !DILocation(line: 35, column: 19, scope: !89)
!94 = !DILocation(line: 35, column: 23, scope: !89)
!95 = !DILocation(line: 35, column: 21, scope: !89)
!96 = !DILocation(line: 35, column: 16, scope: !89)
!97 = !DILocation(line: 35, column: 7, scope: !89)
!98 = !DILocation(line: 35, column: 9, scope: !89)
!99 = !DILocation(line: 35, column: 12, scope: !89)
!100 = !DILocation(line: 34, column: 23, scope: !89)
!101 = !DILocation(line: 34, column: 3, scope: !89)
!102 = distinct !{!102, !92, !103}
!103 = !DILocation(line: 35, column: 25, scope: !86)
!104 = !DILocation(line: 36, column: 10, scope: !105)
!105 = distinct !DILexicalBlock(scope: !64, file: !1, line: 36, column: 3)
!106 = !DILocation(line: 36, column: 8, scope: !105)
!107 = !DILocation(line: 36, column: 15, scope: !108)
!108 = distinct !DILexicalBlock(scope: !105, file: !1, line: 36, column: 3)
!109 = !DILocation(line: 36, column: 19, scope: !108)
!110 = !DILocation(line: 36, column: 17, scope: !108)
!111 = !DILocation(line: 36, column: 3, scope: !105)
!112 = !DILocation(line: 37, column: 12, scope: !113)
!113 = distinct !DILexicalBlock(scope: !108, file: !1, line: 37, column: 5)
!114 = !DILocation(line: 37, column: 10, scope: !113)
!115 = !DILocation(line: 37, column: 17, scope: !116)
!116 = distinct !DILexicalBlock(scope: !113, file: !1, line: 37, column: 5)
!117 = !DILocation(line: 37, column: 21, scope: !116)
!118 = !DILocation(line: 37, column: 19, scope: !116)
!119 = !DILocation(line: 37, column: 5, scope: !113)
!120 = !DILocation(line: 38, column: 31, scope: !116)
!121 = !DILocation(line: 38, column: 33, scope: !116)
!122 = !DILocation(line: 38, column: 32, scope: !116)
!123 = !DILocation(line: 38, column: 38, scope: !116)
!124 = !DILocation(line: 38, column: 36, scope: !116)
!125 = !DILocation(line: 38, column: 17, scope: !116)
!126 = !DILocation(line: 38, column: 46, scope: !116)
!127 = !DILocation(line: 38, column: 45, scope: !116)
!128 = !DILocation(line: 38, column: 43, scope: !116)
!129 = !DILocation(line: 38, column: 41, scope: !116)
!130 = !DILocation(line: 38, column: 7, scope: !116)
!131 = !DILocation(line: 38, column: 9, scope: !116)
!132 = !DILocation(line: 38, column: 12, scope: !116)
!133 = !DILocation(line: 38, column: 15, scope: !116)
!134 = !DILocation(line: 37, column: 25, scope: !116)
!135 = !DILocation(line: 37, column: 5, scope: !116)
!136 = distinct !{!136, !119, !137}
!137 = !DILocation(line: 38, column: 47, scope: !113)
!138 = !DILocation(line: 36, column: 23, scope: !108)
!139 = !DILocation(line: 36, column: 3, scope: !108)
!140 = distinct !{!140, !111, !141}
!141 = !DILocation(line: 38, column: 47, scope: !105)
!142 = !DILocation(line: 39, column: 1, scope: !64)
!143 = distinct !DISubprogram(name: "kernel_atax", scope: !1, file: !1, line: 65, type: !144, scopeLine: 70, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!144 = !DISubroutineType(types: !145)
!145 = !{null, !24, !24, !10, !67, !67, !67}
!146 = !DILocalVariable(name: "m", arg: 1, scope: !143, file: !1, line: 65, type: !24)
!147 = !DILocation(line: 65, column: 22, scope: !143)
!148 = !DILocalVariable(name: "n", arg: 2, scope: !143, file: !1, line: 65, type: !24)
!149 = !DILocation(line: 65, column: 29, scope: !143)
!150 = !DILocalVariable(name: "A", arg: 3, scope: !143, file: !1, line: 66, type: !10)
!151 = !DILocation(line: 66, column: 14, scope: !143)
!152 = !DILocalVariable(name: "x", arg: 4, scope: !143, file: !1, line: 67, type: !67)
!153 = !DILocation(line: 67, column: 14, scope: !143)
!154 = !DILocalVariable(name: "y", arg: 5, scope: !143, file: !1, line: 68, type: !67)
!155 = !DILocation(line: 68, column: 14, scope: !143)
!156 = !DILocalVariable(name: "tmp", arg: 6, scope: !143, file: !1, line: 69, type: !67)
!157 = !DILocation(line: 69, column: 14, scope: !143)
!158 = !DILocalVariable(name: "i", scope: !143, file: !1, line: 71, type: !24)
!159 = !DILocation(line: 71, column: 7, scope: !143)
!160 = !DILocalVariable(name: "j", scope: !143, file: !1, line: 71, type: !24)
!161 = !DILocation(line: 71, column: 10, scope: !143)
!162 = !DILocation(line: 74, column: 10, scope: !163)
!163 = distinct !DILexicalBlock(scope: !143, file: !1, line: 74, column: 3)
!164 = !DILocation(line: 74, column: 8, scope: !163)
!165 = !DILocation(line: 74, column: 15, scope: !166)
!166 = distinct !DILexicalBlock(scope: !163, file: !1, line: 74, column: 3)
!167 = !DILocation(line: 74, column: 19, scope: !166)
!168 = !DILocation(line: 74, column: 17, scope: !166)
!169 = !DILocation(line: 74, column: 3, scope: !163)
!170 = !DILocation(line: 75, column: 5, scope: !166)
!171 = !DILocation(line: 75, column: 7, scope: !166)
!172 = !DILocation(line: 75, column: 10, scope: !166)
!173 = !DILocation(line: 74, column: 27, scope: !166)
!174 = !DILocation(line: 74, column: 3, scope: !166)
!175 = distinct !{!175, !169, !176}
!176 = !DILocation(line: 75, column: 12, scope: !163)
!177 = !DILocation(line: 76, column: 10, scope: !178)
!178 = distinct !DILexicalBlock(scope: !143, file: !1, line: 76, column: 3)
!179 = !DILocation(line: 76, column: 8, scope: !178)
!180 = !DILocation(line: 76, column: 15, scope: !181)
!181 = distinct !DILexicalBlock(scope: !178, file: !1, line: 76, column: 3)
!182 = !DILocation(line: 76, column: 19, scope: !181)
!183 = !DILocation(line: 76, column: 17, scope: !181)
!184 = !DILocation(line: 76, column: 3, scope: !178)
!185 = !DILocation(line: 78, column: 7, scope: !186)
!186 = distinct !DILexicalBlock(scope: !181, file: !1, line: 77, column: 5)
!187 = !DILocation(line: 78, column: 11, scope: !186)
!188 = !DILocation(line: 78, column: 14, scope: !186)
!189 = !DILocation(line: 79, column: 14, scope: !190)
!190 = distinct !DILexicalBlock(scope: !186, file: !1, line: 79, column: 7)
!191 = !DILocation(line: 79, column: 12, scope: !190)
!192 = !DILocation(line: 79, column: 19, scope: !193)
!193 = distinct !DILexicalBlock(scope: !190, file: !1, line: 79, column: 7)
!194 = !DILocation(line: 79, column: 23, scope: !193)
!195 = !DILocation(line: 79, column: 21, scope: !193)
!196 = !DILocation(line: 79, column: 7, scope: !190)
!197 = !DILocation(line: 80, column: 11, scope: !193)
!198 = !DILocation(line: 80, column: 15, scope: !193)
!199 = !DILocation(line: 80, column: 20, scope: !193)
!200 = !DILocation(line: 80, column: 22, scope: !193)
!201 = !DILocation(line: 80, column: 25, scope: !193)
!202 = !DILocation(line: 80, column: 30, scope: !193)
!203 = !DILocation(line: 80, column: 32, scope: !193)
!204 = !DILocation(line: 80, column: 28, scope: !193)
!205 = !DILocation(line: 80, column: 18, scope: !193)
!206 = !DILocation(line: 80, column: 2, scope: !193)
!207 = !DILocation(line: 80, column: 6, scope: !193)
!208 = !DILocation(line: 80, column: 9, scope: !193)
!209 = !DILocation(line: 79, column: 31, scope: !193)
!210 = !DILocation(line: 79, column: 7, scope: !193)
!211 = distinct !{!211, !196, !212}
!212 = !DILocation(line: 80, column: 33, scope: !190)
!213 = !DILocation(line: 81, column: 14, scope: !214)
!214 = distinct !DILexicalBlock(scope: !186, file: !1, line: 81, column: 7)
!215 = !DILocation(line: 81, column: 12, scope: !214)
!216 = !DILocation(line: 81, column: 19, scope: !217)
!217 = distinct !DILexicalBlock(scope: !214, file: !1, line: 81, column: 7)
!218 = !DILocation(line: 81, column: 23, scope: !217)
!219 = !DILocation(line: 81, column: 21, scope: !217)
!220 = !DILocation(line: 81, column: 7, scope: !214)
!221 = !DILocation(line: 82, column: 9, scope: !217)
!222 = !DILocation(line: 82, column: 11, scope: !217)
!223 = !DILocation(line: 82, column: 16, scope: !217)
!224 = !DILocation(line: 82, column: 18, scope: !217)
!225 = !DILocation(line: 82, column: 21, scope: !217)
!226 = !DILocation(line: 82, column: 26, scope: !217)
!227 = !DILocation(line: 82, column: 30, scope: !217)
!228 = !DILocation(line: 82, column: 24, scope: !217)
!229 = !DILocation(line: 82, column: 14, scope: !217)
!230 = !DILocation(line: 82, column: 2, scope: !217)
!231 = !DILocation(line: 82, column: 4, scope: !217)
!232 = !DILocation(line: 82, column: 7, scope: !217)
!233 = !DILocation(line: 81, column: 31, scope: !217)
!234 = !DILocation(line: 81, column: 7, scope: !217)
!235 = distinct !{!235, !220, !236}
!236 = !DILocation(line: 82, column: 31, scope: !214)
!237 = !DILocation(line: 83, column: 5, scope: !186)
!238 = !DILocation(line: 76, column: 27, scope: !181)
!239 = !DILocation(line: 76, column: 3, scope: !181)
!240 = distinct !{!240, !184, !241}
!241 = !DILocation(line: 83, column: 5, scope: !178)
!242 = !DILocation(line: 86, column: 1, scope: !143)
!243 = distinct !DISubprogram(name: "print_array", scope: !1, file: !1, line: 45, type: !244, scopeLine: 48, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!244 = !DISubroutineType(types: !245)
!245 = !{null, !24, !67}
!246 = !DILocalVariable(name: "n", arg: 1, scope: !243, file: !1, line: 45, type: !24)
!247 = !DILocation(line: 45, column: 22, scope: !243)
!248 = !DILocalVariable(name: "y", arg: 2, scope: !243, file: !1, line: 46, type: !67)
!249 = !DILocation(line: 46, column: 14, scope: !243)
!250 = !DILocalVariable(name: "i", scope: !243, file: !1, line: 49, type: !24)
!251 = !DILocation(line: 49, column: 7, scope: !243)
!252 = !DILocation(line: 51, column: 3, scope: !243)
!253 = !DILocation(line: 52, column: 3, scope: !243)
!254 = !DILocation(line: 53, column: 10, scope: !255)
!255 = distinct !DILexicalBlock(scope: !243, file: !1, line: 53, column: 3)
!256 = !DILocation(line: 53, column: 8, scope: !255)
!257 = !DILocation(line: 53, column: 15, scope: !258)
!258 = distinct !DILexicalBlock(scope: !255, file: !1, line: 53, column: 3)
!259 = !DILocation(line: 53, column: 19, scope: !258)
!260 = !DILocation(line: 53, column: 17, scope: !258)
!261 = !DILocation(line: 53, column: 3, scope: !255)
!262 = !DILocation(line: 54, column: 9, scope: !263)
!263 = distinct !DILexicalBlock(scope: !264, file: !1, line: 54, column: 9)
!264 = distinct !DILexicalBlock(scope: !258, file: !1, line: 53, column: 27)
!265 = !DILocation(line: 54, column: 11, scope: !263)
!266 = !DILocation(line: 54, column: 16, scope: !263)
!267 = !DILocation(line: 54, column: 9, scope: !264)
!268 = !DILocation(line: 54, column: 31, scope: !263)
!269 = !DILocation(line: 54, column: 22, scope: !263)
!270 = !DILocation(line: 55, column: 14, scope: !264)
!271 = !DILocation(line: 55, column: 59, scope: !264)
!272 = !DILocation(line: 55, column: 61, scope: !264)
!273 = !DILocation(line: 55, column: 5, scope: !264)
!274 = !DILocation(line: 56, column: 3, scope: !264)
!275 = !DILocation(line: 53, column: 23, scope: !258)
!276 = !DILocation(line: 53, column: 3, scope: !258)
!277 = distinct !{!277, !261, !278}
!278 = !DILocation(line: 56, column: 3, scope: !255)
!279 = !DILocation(line: 57, column: 3, scope: !243)
!280 = !DILocation(line: 58, column: 3, scope: !243)
!281 = !DILocation(line: 59, column: 1, scope: !243)
