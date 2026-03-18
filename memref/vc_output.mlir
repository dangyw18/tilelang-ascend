module attributes {hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @minicv_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf32, #hivm.address_space<gm>>, %arg7: memref<?xf16, #hivm.address_space<gm>>, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c768_i32 = arith.constant 768 : i32
    %1 = arith.muli %c768_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [128, 768], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<128x768xf16, strided<[768, 1]>, #hivm.address_space<gm>>
    %c128_i32 = arith.constant 128 : i32
    %3 = arith.muli %c128_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [768, 128], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<768x128xf16, strided<[128, 1]>, #hivm.address_space<gm>>
    %c32_i32 = arith.constant 32 : i32
    %5 = arith.muli %c32_i32, %c1_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %c64_i32 = arith.constant 64 : i32
    %7 = arith.muli %c64_i32, %5 : i32
    %8 = arith.index_cast %7 : i32 to index
    %c3_i32 = arith.constant 3 : i32
    %9 = arith.muli %c3_i32, %7 : i32
    %10 = arith.index_cast %9 : i32 to index
    %reinterpret_cast_1 = memref.reinterpret_cast %arg7 to offset: [0], sizes: [4, 3, 64, 32], strides: [%10, %8, %6, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<4x3x64x32xf16, strided<[6144, 2048, 32, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [128, 768], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<128x768xf16, strided<[768, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_3 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [128, 128], strides: [%4, %0] : memref<?xf32, #hivm.address_space<gm>> to memref<128x128xf32, strided<[128, 1]>, #hivm.address_space<gm>>
    %11 = hivm.hir.get_block_idx -> i64
    %12 = arith.trunci %11 : i64 to i32
    %13 = hivm.hir.get_sub_block_idx -> i64
    %14 = arith.trunci %13 : i64 to i32
    %alloc = memref.alloc() : memref<64x64xf32, strided<[64, 1]>, #hivm.address_space<cc>>
    %c0_i32 = arith.constant 0 : i32
    %c1_i32_4 = arith.constant 1 : i32
    scf.for %arg14 = %c0_i32 to %c3_i32 step %c1_i32_4  : i32 {
      %c3_i32_6 = arith.constant 3 : i32
      %21 = arith.addi %arg14, %c3_i32_6 : i32
      %22 = arith.extsi %21 : i32 to i64
      hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = %22 syn_instr_mode = <INTRA_BLOCK_SYNCHRONIZATION>
    }
    %c8_i32 = arith.constant 8 : i32
    %c1_i32_5 = arith.constant 1 : i32
    scf.for %arg14 = %c0_i32 to %c8_i32 step %c1_i32_5  : i32 {
      %c0_i32_6 = arith.constant 0 : i32
      %c3_i32_7 = arith.constant 3 : i32
      %c1_i32_8 = arith.constant 1 : i32
      scf.for %arg15 = %c0_i32_6 to %c3_i32_7 step %c1_i32_8  : i32 {
        %alloc_9 = memref.alloc() : memref<64x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>>
        %alloc_10 = memref.alloc() : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>
        %21 = arith.extsi %arg15 : i32 to i64
        hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_MTE2>] flag = %21
        %c96_i32 = arith.constant 96 : i32
        %22 = arith.muli %arg14, %c96_i32 : i32
        %c32_i32_11 = arith.constant 32 : i32
        %23 = arith.muli %arg15, %c32_i32_11 : i32
        %24 = arith.addi %22, %23 : i32
        %25 = arith.index_cast %24 : i32 to index
        %c2_i32_12 = arith.constant 2 : i32
        %26 = arith.remsi %12, %c2_i32_12 : i32
        %c64_i32_13 = arith.constant 64 : i32
        %27 = arith.muli %26, %c64_i32_13 : i32
        %28 = arith.index_cast %27 : i32 to index
        %subview_14 = memref.subview %reinterpret_cast_0[%25, %28] [32, 64] [1, 1] : memref<768x128xf16, strided<[128, 1]>, #hivm.address_space<gm>> to memref<32x64xf16, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>
        hivm.hir.nd2nz {dst_continuous} ins(%subview_14 : memref<32x64xf16, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>) outs(%alloc_10 : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>) init_out_buffer = false
        %29 = arith.index_cast %12 : i32 to index
        %30 = arith.index_cast %arg15 : i32 to index
        %subview_15 = memref.subview %reinterpret_cast_1[%29, %30, 0, 0] [1, 1, 64, 32] [1, 1, 1, 1] : memref<4x3x64x32xf16, strided<[6144, 2048, 32, 1]>, #hivm.address_space<gm>> to memref<64x32xf16, strided<[32, 1], offset: ?>, #hivm.address_space<gm>>
        hivm.hir.nd2nz {dst_continuous} ins(%subview_15 : memref<64x32xf16, strided<[32, 1], offset: ?>, #hivm.address_space<gm>>) outs(%alloc_9 : memref<64x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>>) init_out_buffer = false
        %c3_i32_16 = arith.constant 3 : i32
        %31 = arith.muli %arg14, %c3_i32_16 : i32
        %32 = arith.addi %31, %arg15 : i32
        %c0_i32_17 = arith.constant 0 : i32
        %33 = arith.cmpi eq, %32, %c0_i32_17 : i32
        %34 = arith.index_cast %c64_i32_13 : i32 to index
        %35 = arith.index_cast %c32_i32_11 : i32 to index
        hivm.hir.mmadL1 ins(%alloc_9, %alloc_10, %33, %34, %35, %34 : memref<64x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>>, memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc : memref<64x64xf32, strided<[64, 1]>, #hivm.address_space<cc>>)
        %36 = arith.addi %arg15, %c3_i32_16 : i32
        %37 = arith.extsi %36 : i32 to i64
        hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = %37 syn_instr_mode = <INTRA_BLOCK_SYNCHRONIZATION>
      }
    }
    %c2_i32 = arith.constant 2 : i32
    %15 = arith.divsi %12, %c2_i32 : i32
    %16 = arith.muli %15, %c64_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.remsi %12, %c2_i32 : i32
    %19 = arith.muli %18, %c64_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview = memref.subview %reinterpret_cast_3[%17, %20] [64, 64] [1, 1] : memref<128x128xf32, strided<[128, 1]>, #hivm.address_space<gm>> to memref<64x64xf32, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe {enable_nz2nd} ins(%alloc : memref<64x64xf32, strided<[64, 1]>, #hivm.address_space<cc>>) outs(%subview : memref<64x64xf32, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>)
    return
  }
  func.func @minicv_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf32, #hivm.address_space<gm>>, %arg7: memref<?xf16, #hivm.address_space<gm>>, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c768_i32 = arith.constant 768 : i32
    %1 = arith.muli %c768_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [128, 768], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<128x768xf16, strided<[768, 1]>, #hivm.address_space<gm>>
    %c128_i32 = arith.constant 128 : i32
    %3 = arith.muli %c128_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [768, 128], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<768x128xf16, strided<[128, 1]>, #hivm.address_space<gm>>
    %c32_i32 = arith.constant 32 : i32
    %5 = arith.muli %c32_i32, %c1_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %c64_i32 = arith.constant 64 : i32
    %7 = arith.muli %c64_i32, %5 : i32
    %8 = arith.index_cast %7 : i32 to index
    %c3_i32 = arith.constant 3 : i32
    %9 = arith.muli %c3_i32, %7 : i32
    %10 = arith.index_cast %9 : i32 to index
    %reinterpret_cast_1 = memref.reinterpret_cast %arg7 to offset: [0], sizes: [4, 3, 64, 32], strides: [%10, %8, %6, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<4x3x64x32xf16, strided<[6144, 2048, 32, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [128, 768], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<128x768xf16, strided<[768, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_3 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [128, 128], strides: [%4, %0] : memref<?xf32, #hivm.address_space<gm>> to memref<128x128xf32, strided<[128, 1]>, #hivm.address_space<gm>>
    %11 = hivm.hir.get_block_idx -> i64
    %12 = arith.trunci %11 : i64 to i32
    %13 = hivm.hir.get_sub_block_idx -> i64
    %14 = arith.trunci %13 : i64 to i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32_4 = arith.constant 1 : i32
    scf.for %arg14 = %c0_i32 to %c8_i32 step %c1_i32_4  : i32 {
      %c0_i32_6 = arith.constant 0 : i32
      %c3_i32_7 = arith.constant 3 : i32
      %c1_i32_8 = arith.constant 1 : i32
      scf.for %arg15 = %c0_i32_6 to %c3_i32_7 step %c1_i32_8  : i32 {
        %alloc = memref.alloc() : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<ub>>
        %alloc_9 = memref.alloc() : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<ub>>
        %c3_i32_10 = arith.constant 3 : i32
        %15 = arith.addi %arg15, %c3_i32_10 : i32
        %16 = arith.extsi %15 : i32 to i64
        hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = %16
        %c2_i32 = arith.constant 2 : i32
        %17 = arith.divsi %12, %c2_i32 : i32
        %c64_i32_11 = arith.constant 64 : i32
        %18 = arith.muli %17, %c64_i32_11 : i32
        %c32_i32_12 = arith.constant 32 : i32
        %19 = arith.muli %14, %c32_i32_12 : i32
        %20 = arith.addi %18, %19 : i32
        %21 = arith.index_cast %20 : i32 to index
        %c96_i32 = arith.constant 96 : i32
        %22 = arith.muli %arg14, %c96_i32 : i32
        %23 = arith.muli %arg15, %c32_i32_12 : i32
        %24 = arith.addi %22, %23 : i32
        %25 = arith.index_cast %24 : i32 to index
        %subview = memref.subview %reinterpret_cast[%21, %25] [32, 32] [1, 1] : memref<128x768xf16, strided<[768, 1]>, #hivm.address_space<gm>> to memref<32x32xf16, strided<[768, 1], offset: ?>, #hivm.address_space<gm>>
        memref.copy %subview, %alloc : memref<32x32xf16, strided<[768, 1], offset: ?>, #hivm.address_space<gm>> to memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<ub>>
        hivm.hir.vexp ins(%alloc : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<ub>>) outs(%alloc_9 : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<ub>>)
        %26 = arith.index_cast %12 : i32 to index
        %27 = arith.index_cast %arg15 : i32 to index
        %28 = arith.index_cast %19 : i32 to index
        %subview_13 = memref.subview %reinterpret_cast_1[%26, %27, %28, 0] [1, 1, 32, 32] [1, 1, 1, 1] : memref<4x3x64x32xf16, strided<[6144, 2048, 32, 1]>, #hivm.address_space<gm>> to memref<1x1x32x32xf16, strided<[6144, 2048, 32, 1], offset: ?>, #hivm.address_space<gm>>
        %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %alloc_9 : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<ub>> -> memref<f16, #hivm.address_space<ub>>, index, index, index, index, index
        %c1 = arith.constant 1 : index
        %c1_14 = arith.constant 1 : index
        %c32 = arith.constant 32 : index
        %c32_15 = arith.constant 32 : index
        %reinterpret_cast_16 = memref.reinterpret_cast %alloc_9 to offset: [%offset], sizes: [1, 1, 32, 32], strides: [1024, 1024, 32, 1] : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<ub>> to memref<1x1x32x32xf16, strided<[1024, 1024, 32, 1], offset: ?>, #hivm.address_space<ub>>
        memref.copy %reinterpret_cast_16, %subview_13 : memref<1x1x32x32xf16, strided<[1024, 1024, 32, 1], offset: ?>, #hivm.address_space<ub>> to memref<1x1x32x32xf16, strided<[6144, 2048, 32, 1], offset: ?>, #hivm.address_space<gm>>
        %29 = arith.extsi %arg15 : i32 to i64
        hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE3>, <PIPE_S>] flag = %29 syn_instr_mode = <INTRA_BLOCK_SYNCHRONIZATION>
      }
    }
    %c1_i32_5 = arith.constant 1 : i32
    scf.for %arg14 = %c0_i32 to %c3_i32 step %c1_i32_5  : i32 {
      %c3_i32_6 = arith.constant 3 : i32
      %15 = arith.addi %arg14, %c3_i32_6 : i32
      %16 = arith.extsi %15 : i32 to i64
      hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = %16
    }
    return
  }
}