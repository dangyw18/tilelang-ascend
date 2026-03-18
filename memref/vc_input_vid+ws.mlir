module attributes {hivm.module_core_type = #hivm.module_core_type<AIC>, memref.memref_as_ptr} {
  func.func @minicv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf32, #hivm.address_space<gm>>, %arg7: memref<?xf16, #hivm.address_space<gm>>, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, mix_mode = "aic"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c256_i32 = arith.constant 256 : i32
    %1 = arith.muli %c256_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [128, 256], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<128x256xf16, strided<[256, 1]>, #hivm.address_space<gm>>
    %c128_i32 = arith.constant 128 : i32
    %3 = arith.muli %c128_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [256, 128], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<256x128xf16, strided<[128, 1]>, #hivm.address_space<gm>>
    %c32_i32 = arith.constant 32 : i32
    %5 = arith.muli %c32_i32, %c1_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %c64_i32 = arith.constant 64 : i32
    %7 = arith.muli %c64_i32, %5 : i32
    %8 = arith.index_cast %7 : i32 to index
    %reinterpret_cast_1 = memref.reinterpret_cast %arg7 to offset: [0], sizes: [4, 64, 32], strides: [%8, %6, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<4x64x32xf16, strided<[2048, 32, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [128, 256], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<128x256xf16, strided<[256, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_3 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [128, 128], strides: [%4, %0] : memref<?xf32, #hivm.address_space<gm>> to memref<128x128xf32, strided<[128, 1]>, #hivm.address_space<gm>>
    %9 = hivm.hir.get_block_idx -> i64 //cid
    %10 = arith.trunci %9 : i64 to i32
    %11 = hivm.hir.get_sub_block_idx -> i64 //vid
    %12 = arith.trunci %11 : i64 to i32
    %alloc = memref.alloc() : memref<64x64xf32, strided<[64, 1]>, #hivm.address_space<cbuf>> //D_BUF
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32_4 = arith.constant 1 : i32
    scf.for %arg14 = %c0_i32 to %c8_i32 step %c1_i32_4  : i32 {
      %alloc_5 = memref.alloc() : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>> //A_BUF
      %alloc_6 = memref.alloc() : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>> //B_BUF
      %alloc_7 = memref.alloc() : memref<64x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>> //B_L1
      %alloc_8 = memref.alloc() : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>> //C_BUF
      %c2_i32_9 = arith.constant 2 : i32
      %19 = arith.divsi %10, %c2_i32_9 : i32
      %c64_i32_10 = arith.constant 64 : i32
      %20 = arith.muli %19, %c64_i32_10 : i32
      %c32_i32_11 = arith.constant 32 : i32
      %21 = arith.muli %12, %c32_i32_11 : i32
      %22 = arith.addi %20, %21 : i32
      %23 = arith.index_cast %22 : i32 to index //vid
      %24 = arith.muli %arg14, %c32_i32_11 : i32
      %25 = arith.index_cast %24 : i32 to index //k
      %subview_12 = memref.subview %reinterpret_cast[%23, %25] [32, 32] [1, 1] : memref<128x256xf16, strided<[256, 1]>, #hivm.address_space<gm>> to memref<32x32xf16, strided<[256, 1], offset: ?>, #hivm.address_space<gm>> //A->A_BUF
      hivm.hir.nd2nz {dst_continuous} ins(%subview_12 : memref<32x32xf16, strided<[256, 1], offset: ?>, #hivm.address_space<gm>>) outs(%alloc_5 : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>>) init_out_buffer = false
      %26 = arith.remsi %10, %c2_i32_9 : i32
      %27 = arith.muli %26, %c64_i32_10 : i32
      %28 = arith.index_cast %27 : i32 to index
      %subview_13 = memref.subview %reinterpret_cast_0[%25, %28] [32, 64] [1, 1] : memref<256x128xf16, strided<[128, 1]>, #hivm.address_space<gm>> to memref<32x64xf16, strided<[128, 1], offset: ?>, #hivm.address_space<gm>> //C->C_BUF
      hivm.hir.nd2nz {dst_continuous} ins(%subview_13 : memref<32x64xf16, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>) outs(%alloc_8 : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>) init_out_buffer = false
      hivm.hir.vexp ins(%alloc_5 : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>>) outs(%alloc_6 : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>>)
      %29 = arith.index_cast %10 : i32 to index
      %30 = arith.index_cast %21 : i32 to index
      %subview_14 = memref.subview %reinterpret_cast_1[%29, %30, 0] [1, 32, 32] [1, 1, 1] : memref<4x64x32xf16, strided<[2048, 32, 1]>, #hivm.address_space<gm>> to memref<32x32xf16, strided<[32, 1], offset: ?>, #hivm.address_space<gm>> //Workspace
      memref.copy %alloc_6, %subview_14 : memref<32x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>> to memref<32x32xf16, strided<[32, 1], offset: ?>, #hivm.address_space<gm>> //B_BUF->workspace
      %subview_15 = memref.subview %reinterpret_cast_1[%29, 0, 0] [1, 64, 32] [1, 1, 1] : memref<4x64x32xf16, strided<[2048, 32, 1]>, #hivm.address_space<gm>> to memref<64x32xf16, strided<[32, 1], offset: ?>, #hivm.address_space<gm>> //workspace->B_L1
      hivm.hir.nd2nz {dst_continuous} ins(%subview_15 : memref<64x32xf16, strided<[32, 1], offset: ?>, #hivm.address_space<gm>>) outs(%alloc_7 : memref<64x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>>) init_out_buffer = false
      %c0_i32_16 = arith.constant 0 : i32
      %31 = arith.cmpi eq, %arg14, %c0_i32_16 : i32
      %32 = arith.index_cast %c64_i32_10 : i32 to index
      %33 = arith.index_cast %c32_i32_11 : i32 to index
      hivm.hir.mmadL1 ins(%alloc_7, %alloc_8, %31, %32, %33, %32 : memref<64x32xf16, strided<[32, 1]>, #hivm.address_space<cbuf>>, memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc : memref<64x64xf32, strided<[64, 1]>, #hivm.address_space<cbuf>>)
    }
    %c2_i32 = arith.constant 2 : i32
    %13 = arith.divsi %10, %c2_i32 : i32 //blockx
    %14 = arith.muli %13, %c64_i32 : i32 //bx
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %10, %c2_i32 : i32 //blocky
    %17 = arith.muli %16, %c64_i32 : i32 //by
    %18 = arith.index_cast %17 : i32 to index
    %subview = memref.subview %reinterpret_cast_3[%15, %18] [64, 64] [1, 1] : memref<128x128xf32, strided<[128, 1]>, #hivm.address_space<gm>> to memref<64x64xf32, strided<[128, 1], offset: ?>, #hivm.address_space<gm>> //D_BUF
    memref.copy %alloc, %subview : memref<64x64xf32, strided<[64, 1]>, #hivm.address_space<cbuf>> to memref<64x64xf32, strided<[128, 1], offset: ?>, #hivm.address_space<gm>> //D_BUF->D
    return
  }
}