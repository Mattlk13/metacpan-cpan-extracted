package Java::JVM::Classfile::Ops;

require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(%ops);

# Here begins autogenerated stuff
use constant T_BOOLEAN => 4;
use constant T_CHAR    => 5;
use constant T_FLOAT   => 6;
use constant T_DOUBLE  => 7;
use constant T_BYTE    => 8;
use constant T_SHORT   => 9;
use constant T_INT     => 10;
use constant T_LONG    => 11;
use constant T_VOID      => 12;
use constant T_ARRAY     => 13;
use constant T_OBJECT    => 14;
use constant T_REFERENCE => 14;
use constant T_UNKNOWN   => 15;
use constant T_ADDRESS   => 16;

%ops = (
  0 => {
             name => 'nop',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 0,
             type => 'noargs',
  },
  1 => {
             name => 'aconst_null',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  2 => {
             name => 'iconst_m1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  3 => {
             name => 'iconst_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  4 => {
             name => 'iconst_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  5 => {
             name => 'iconst_2',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  6 => {
             name => 'iconst_3',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  7 => {
             name => 'iconst_4',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  8 => {
             name => 'iconst_5',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  9 => {
             name => 'lconst_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  10 => {
             name => 'lconst_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  11 => {
             name => 'fconst_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  12 => {
             name => 'fconst_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  13 => {
             name => 'fconst_2',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  14 => {
             name => 'dconst_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  15 => {
             name => 'dconst_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  16 => {
             name => 'bipush',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 1,
             type => 'byte',
  },
  17 => {
             name => 'sipush',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 0,
         produced => 1,
             type => 'int',
  },
  18 => {
             name => 'ldc',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 1,
             type => 'byteindex',
  },
  19 => {
             name => 'ldc_w',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 0,
         produced => 1,
             type => 'twobytes',
  },
  20 => {
             name => 'ldc2_w',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 0,
         produced => 2,
             type => 'twobytes',
  },
  21 => {
             name => 'iload',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 1,
             type => 'bytevar',
  },
  22 => {
             name => 'lload',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 2,
             type => 'bytevar',
  },
  23 => {
             name => 'fload',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 1,
             type => 'bytevar',
  },
  24 => {
             name => 'dload',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 2,
             type => 'bytevar',
  },
  25 => {
             name => 'aload',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 1,
             type => 'bytevar',
  },
  26 => {
             name => 'iload_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  27 => {
             name => 'iload_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  28 => {
             name => 'iload_2',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  29 => {
             name => 'iload_3',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  30 => {
             name => 'lload_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  31 => {
             name => 'lload_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  32 => {
             name => 'lload_2',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  33 => {
             name => 'lload_3',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  34 => {
             name => 'fload_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  35 => {
             name => 'fload_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  36 => {
             name => 'fload_2',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  37 => {
             name => 'fload_3',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  38 => {
             name => 'dload_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  39 => {
             name => 'dload_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  40 => {
             name => 'dload_2',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  41 => {
             name => 'dload_3',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 2,
             type => 'noargs',
  },
  42 => {
             name => 'aload_0',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  43 => {
             name => 'aload_1',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  44 => {
             name => 'aload_2',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  45 => {
             name => 'aload_3',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 1,
             type => 'noargs',
  },
  46 => {
             name => 'iaload',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  47 => {
             name => 'laload',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 2,
             type => 'noargs',
  },
  48 => {
             name => 'faload',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  49 => {
             name => 'daload',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 2,
             type => 'noargs',
  },
  50 => {
             name => 'aaload',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  51 => {
             name => 'baload',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  52 => {
             name => 'caload',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  53 => {
             name => 'saload',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  54 => {
             name => 'istore',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 1,
         produced => 0,
             type => 'bytevar',
  },
  55 => {
             name => 'lstore',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 2,
         produced => 0,
             type => 'bytevar',
  },
  56 => {
             name => 'fstore',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 1,
         produced => 0,
             type => 'bytevar',
  },
  57 => {
             name => 'dstore',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 2,
         produced => 0,
             type => 'bytevar',
  },
  58 => {
             name => 'astore',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 1,
         produced => 0,
             type => 'bytevar',
  },
  59 => {
             name => 'istore_0',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  60 => {
             name => 'istore_1',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  61 => {
             name => 'istore_2',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  62 => {
             name => 'istore_3',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  63 => {
             name => 'lstore_0',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  64 => {
             name => 'lstore_1',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  65 => {
             name => 'lstore_2',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  66 => {
             name => 'lstore_3',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  67 => {
             name => 'fstore_0',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  68 => {
             name => 'fstore_1',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  69 => {
             name => 'fstore_2',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  70 => {
             name => 'fstore_3',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  71 => {
             name => 'dstore_0',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  72 => {
             name => 'dstore_1',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  73 => {
             name => 'dstore_2',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  74 => {
             name => 'dstore_3',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  75 => {
             name => 'astore_0',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  76 => {
             name => 'astore_1',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  77 => {
             name => 'astore_2',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  78 => {
             name => 'astore_3',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  79 => {
             name => 'iastore',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 0,
             type => 'noargs',
  },
  80 => {
             name => 'lastore',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 0,
             type => 'noargs',
  },
  81 => {
             name => 'fastore',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 0,
             type => 'noargs',
  },
  82 => {
             name => 'dastore',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 0,
             type => 'noargs',
  },
  83 => {
             name => 'aastore',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 0,
             type => 'noargs',
  },
  84 => {
             name => 'bastore',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 0,
             type => 'noargs',
  },
  85 => {
             name => 'castore',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 0,
             type => 'noargs',
  },
  86 => {
             name => 'sastore',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 0,
             type => 'noargs',
  },
  87 => {
             name => 'pop',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  88 => {
             name => 'pop2',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  89 => {
             name => 'dup',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 2,
             type => 'noargs',
  },
  90 => {
             name => 'dup_x1',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 3,
             type => 'noargs',
  },
  91 => {
             name => 'dup_x2',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 4,
             type => 'noargs',
  },
  92 => {
             name => 'dup2',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 4,
             type => 'noargs',
  },
  93 => {
             name => 'dup2_x1',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 5,
             type => 'noargs',
  },
  94 => {
             name => 'dup2_x2',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 6,
             type => 'noargs',
  },
  95 => {
             name => 'swap',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 2,
             type => 'noargs',
  },
  96 => {
             name => 'iadd',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  97 => {
             name => 'ladd',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  98 => {
             name => 'fadd',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  99 => {
             name => 'dadd',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  100 => {
             name => 'isub',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  101 => {
             name => 'lsub',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  102 => {
             name => 'fsub',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  103 => {
             name => 'dsub',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  104 => {
             name => 'imul',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  105 => {
             name => 'lmul',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  106 => {
             name => 'fmul',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  107 => {
             name => 'dmul',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  108 => {
             name => 'idiv',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  109 => {
             name => 'ldiv',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  110 => {
             name => 'fdiv',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  111 => {
             name => 'ddiv',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  112 => {
             name => 'irem',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  113 => {
             name => 'lrem',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  114 => {
             name => 'frem',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  115 => {
             name => 'drem',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  116 => {
             name => 'ineg',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => 'noargs',
  },
  117 => {
             name => 'lneg',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 2,
             type => 'noargs',
  },
  118 => {
             name => 'fneg',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => 'noargs',
  },
  119 => {
             name => 'dneg',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 2,
             type => 'noargs',
  },
  120 => {
             name => 'ishl',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  121 => {
             name => 'lshl',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 2,
             type => 'noargs',
  },
  122 => {
             name => 'ishr',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  123 => {
             name => 'lshr',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 2,
             type => 'noargs',
  },
  124 => {
             name => 'iushr',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  125 => {
             name => 'lushr',
         operands => 0,
    operand_types => [],
         consumed => 3,
         produced => 2,
             type => 'noargs',
  },
  126 => {
             name => 'iand',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  127 => {
             name => 'land',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  128 => {
             name => 'ior',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  129 => {
             name => 'lor',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  130 => {
             name => 'ixor',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  131 => {
             name => 'lxor',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 2,
             type => 'noargs',
  },
  132 => {
             name => 'iinc',
         operands => 2,
    operand_types => [T_BYTE, T_BYTE],
         consumed => 0,
         produced => 0,
             type => 'twobytes',
  },
  133 => {
             name => 'i2l',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 2,
             type => 'noargs',
  },
  134 => {
             name => 'i2f',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => 'noargs',
  },
  135 => {
             name => 'i2d',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 2,
             type => 'noargs',
  },
  136 => {
             name => 'l2i',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  137 => {
             name => 'l2f',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  138 => {
             name => 'l2d',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 2,
             type => 'noargs',
  },
  139 => {
             name => 'f2i',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => 'noargs',
  },
  140 => {
             name => 'f2l',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 2,
             type => 'noargs',
  },
  141 => {
             name => 'f2d',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 2,
             type => 'noargs',
  },
  142 => {
             name => 'd2i',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  143 => {
             name => 'd2l',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 2,
             type => 'noargs',
  },
  144 => {
             name => 'd2f',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  145 => {
             name => 'i2b',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => '',
  },
  146 => {
             name => 'i2c',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => '',
  },
  147 => {
             name => 'i2s',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => '',
  },
  148 => {
             name => 'lcmp',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 1,
             type => 'noargs',
  },
  149 => {
             name => 'fcmpl',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  150 => {
             name => 'fcmpg',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 1,
             type => 'noargs',
  },
  151 => {
             name => 'dcmpl',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 1,
             type => 'noargs',
  },
  152 => {
             name => 'dcmpg',
         operands => 0,
    operand_types => [],
         consumed => 4,
         produced => 1,
             type => 'noargs',
  },
  153 => {
             name => 'ifeq',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 0,
             type => 'intbranch',
  },
  154 => {
             name => 'ifne',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 0,
             type => 'intbranch',
  },
  155 => {
             name => 'iflt',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 0,
             type => 'intbranch',
  },
  156 => {
             name => 'ifge',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 0,
             type => 'intbranch',
  },
  157 => {
             name => 'ifgt',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 0,
             type => 'intbranch',
  },
  158 => {
             name => 'ifle',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 0,
             type => 'intbranch',
  },
  159 => {
             name => 'if_icmpeq',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 2,
         produced => 0,
             type => 'intbranch',
  },
  160 => {
             name => 'if_icmpne',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 2,
         produced => 0,
             type => 'intbranch',
  },
  161 => {
             name => 'if_icmplt',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 2,
         produced => 0,
             type => 'intbranch',
  },
  162 => {
             name => 'if_icmpge',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 2,
         produced => 0,
             type => 'intbranch',
  },
  163 => {
             name => 'if_icmpgt',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 2,
         produced => 0,
             type => 'intbranch',
  },
  164 => {
             name => 'if_icmple',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 2,
         produced => 0,
             type => 'intbranch',
  },
  165 => {
             name => 'if_acmpeq',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 2,
         produced => 0,
             type => 'intbranch',
  },
  166 => {
             name => 'if_acmpne',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 2,
         produced => 0,
             type => 'intbranch',
  },
  167 => {
             name => 'goto',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 0,
         produced => 0,
             type => 'intbranch',
  },
  168 => {
             name => 'jsr',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 0,
         produced => 1,
             type => 'intbranch',
  },
  169 => {
             name => 'ret',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 0,
             type => 'bytevar',
  },
  170 => {
             name => 'tableswitch',
         operands => undef,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => '',
  },
  171 => {
             name => 'lookupswitch',
         operands => undef,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => '',
  },
  172 => {
             name => 'ireturn',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  173 => {
             name => 'lreturn',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  174 => {
             name => 'freturn',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  175 => {
             name => 'dreturn',
         operands => 0,
    operand_types => [],
         consumed => 2,
         produced => 0,
             type => 'noargs',
  },
  176 => {
             name => 'areturn',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  177 => {
             name => 'return',
         operands => 0,
    operand_types => [],
         consumed => 0,
         produced => 0,
             type => 'noargs',
  },
  178 => {
             name => 'getstatic',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 0,
         produced => undef,
             type => 'intindex',
  },
  179 => {
             name => 'putstatic',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => undef,
         produced => 0,
             type => 'intindex',
  },
  180 => {
             name => 'getfield',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => undef,
             type => 'intindex',
  },
  181 => {
             name => 'putfield',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => undef,
         produced => 0,
             type => 'intindex',
  },
  182 => {
             name => 'invokevirtual',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => undef,
         produced => undef,
             type => 'intindex',
  },
  183 => {
             name => 'invokespecial',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => undef,
         produced => undef,
             type => 'intindex',
  },
  184 => {
             name => 'invokestatic',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => undef,
         produced => undef,
             type => 'intindex',
  },
  185 => {
             name => 'invokeinterface',
         operands => 4,
    operand_types => [T_SHORT, T_BYTE, T_BYTE],
         consumed => undef,
         produced => undef,
             type => 'intindex',
  },
  187 => {
             name => 'new',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 0,
         produced => 1,
             type => 'intindex',
  },
  188 => {
             name => 'newarray',
         operands => 1,
    operand_types => [T_BYTE],
         consumed => 1,
         produced => 1,
             type => 'byte',
  },
  189 => {
             name => 'anewarray',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 1,
             type => 'intindex',
  },
  190 => {
             name => 'arraylength',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => 'noargs',
  },
  191 => {
             name => 'athrow',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 1,
             type => 'noargs',
  },
  192 => {
             name => 'checkcast',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 1,
             type => 'intindex',
  },
  193 => {
             name => 'instanceof',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 1,
             type => 'intindex',
  },
  194 => {
             name => 'monitorenter',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  195 => {
             name => 'monitorexit',
         operands => 0,
    operand_types => [],
         consumed => 1,
         produced => 0,
             type => 'noargs',
  },
  196 => {
             name => 'wide',
         operands => undef,
    operand_types => [T_BYTE],
         consumed => 0,
         produced => 0,
             type => 'noargs',
  },
  197 => {
             name => 'multianewarray',
         operands => 3,
    operand_types => [T_SHORT, T_BYTE],
         consumed => undef,
         produced => 1,
             type => 'intindex',
  },
  198 => {
             name => 'ifnull',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 0,
             type => 'intbranch',
  },
  199 => {
             name => 'ifnonnull',
         operands => 2,
    operand_types => [T_SHORT],
         consumed => 1,
         produced => 0,
             type => 'intbranch',
  },
  200 => {
             name => 'goto_w',
         operands => 4,
    operand_types => [T_INT],
         consumed => 0,
         produced => 0,
             type => 'longbranch',
  },
  201 => {
             name => 'jsr_w',
         operands => 4,
    operand_types => [T_INT],
         consumed => 0,
         produced => 1,
             type => 'longbranch',
  },
  202 => {
             name => 'breakpoint',
         operands => 0,
    operand_types => undef,
         consumed => 0,
         produced => 0,
             type => 'noargs',
  },
  254 => {
             name => 'impdep1',
         operands => undef,
    operand_types => undef,
         consumed => undef,
         produced => undef,
             type => '',
  },
  255 => {
             name => 'impdep2',
         operands => undef,
    operand_types => undef,
         consumed => undef,
         produced => undef,
             type => '',
  },
);
# Here ends autogenerated stuff
