module attributes {hivm.module_core_type = #hivm.module_core_type<AIC>, memref.memref_as_ptr} {
  func.func @minicv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf32, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, mix_mode = "aic"} {
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
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [128, 256], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<128x256xf16, strided<[256, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [128, 128], strides: [%4, %0] : memref<?xf32, #hivm.address_space<gm>> to memref<128x128xf32, strided<[128, 1]>, #hivm.address_space<gm>>
    %5 = hivm.hir.get_block_idx -> i64
    %6 = arith.trunci %5 : i64 to i32
    %alloc = memref.alloc() : memref<32x64xf32, strided<[64, 1]>, #hivm.address_space<cbuf>>
    %c0_i32 = arith.constant 0 : i32
    %c4_i32 = arith.constant 4 : i32
    %c1_i32_3 = arith.constant 1 : i32
    scf.for %arg13 = %c0_i32 to %c4_i32 step %c1_i32_3  : i32 {
      %alloc_4 = memref.alloc() : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>
      %alloc_5 = memref.alloc() : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>
      %alloc_6 = memref.alloc() : memref<64x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>
      %c2_i32_7 = arith.constant 2 : i32
      %13 = arith.divsi %6, %c2_i32_7 : i32
      %c32_i32_8 = arith.constant 32 : i32
      %14 = arith.muli %13, %c32_i32_8 : i32
      %15 = arith.index_cast %14 : i32 to index
      %c64_i32_9 = arith.constant 64 : i32
      %16 = arith.muli %arg13, %c64_i32_9 : i32
      %17 = arith.index_cast %16 : i32 to index
      %subview_10 = memref.subview %reinterpret_cast[%15, %17] [32, 64] [1, 1] : memref<128x256xf16, strided<[256, 1]>, #hivm.address_space<gm>> to memref<32x64xf16, strided<[256, 1], offset: ?>, #hivm.address_space<gm>>
      hivm.hir.nd2nz {dst_continuous} ins(%subview_10 : memref<32x64xf16, strided<[256, 1], offset: ?>, #hivm.address_space<gm>>) outs(%alloc_4 : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>) init_out_buffer = false
      %18 = arith.remsi %6, %c2_i32_7 : i32
      %19 = arith.muli %18, %c64_i32_9 : i32
      %20 = arith.index_cast %19 : i32 to index
      %subview_11 = memref.subview %reinterpret_cast_0[%17, %20] [64, 64] [1, 1] : memref<256x128xf16, strided<[128, 1]>, #hivm.address_space<gm>> to memref<64x64xf16, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>
      hivm.hir.nd2nz {dst_continuous} ins(%subview_11 : memref<64x64xf16, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>) outs(%alloc_6 : memref<64x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>) init_out_buffer = false
      hivm.hir.vexp ins(%alloc_4 : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>) outs(%alloc_5 : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>)
      %c0_i32_12 = arith.constant 0 : i32
      %21 = arith.cmpi eq, %arg13, %c0_i32_12 : i32
      %22 = arith.index_cast %c32_i32_8 : i32 to index
      %23 = arith.index_cast %c64_i32_9 : i32 to index
      hivm.hir.mmadL1 ins(%alloc_5, %alloc_6, %21, %22, %23, %23 : memref<32x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>, memref<64x64xf16, strided<[64, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc : memref<32x64xf32, strided<[64, 1]>, #hivm.address_space<cbuf>>)
    }
    %c2_i32 = arith.constant 2 : i32
    %7 = arith.divsi %6, %c2_i32 : i32
    %c32_i32 = arith.constant 32 : i32
    %8 = arith.muli %7, %c32_i32 : i32
    %9 = arith.index_cast %8 : i32 to index
    %10 = arith.remsi %6, %c2_i32 : i32
    %c64_i32 = arith.constant 64 : i32
    %11 = arith.muli %10, %c64_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %subview = memref.subview %reinterpret_cast_2[%9, %12] [32, 64] [1, 1] : memref<128x128xf32, strided<[128, 1]>, #hivm.address_space<gm>> to memref<32x64xf32, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %alloc, %subview : memref<32x64xf32, strided<[64, 1]>, #hivm.address_space<cbuf>> to memref<32x64xf32, strided<[128, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}