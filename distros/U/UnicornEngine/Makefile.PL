use 5.014002;
use ExtUtils::MakeMaker;
use Alien::UnicornEngine;
my $alien = Alien::UnicornEngine->new;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'UnicornEngine',
    VERSION_FROM      => 'lib/UnicornEngine.pm', # finds $VERSION
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
        'File::ShareDir' => 0,
        'File::Copy' => 0,
        'File::Spec' => 0,
    },
    PREREQ_PM         => {
        'Alien::UnicornEngine' => 0.04,
        'Math::Int64' => 0,
    }, # e.g., Module::Name => 1.1
    BUILD_REQUIRES  => {
        'Test::More' => 0,
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/UnicornEngine.pm', # retrieve abstract from module
       AUTHOR         => 'Vikas Kumar <vikas@cpan.org>') : ()),
    LIBS              => $alien->libs(),
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => $alien->cflags(),
	# Un-comment this if you add C files to link with later:
     OBJECT            => '$(O_FILES)',# link all the C files too
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url => 'https://github.com/selectiveintellect/p5-unicorn',
            },
            bugtracker => 'https://github.com/selectiveintellect/p5-unicorn/issues',
        },
    },
    LICENSE => 'perl',
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (qw(),
              {name=>"UC_ARCH_ARM", macro=>"1"},
              {name=>"UC_ARCH_ARM64", macro=>"1"},
              {name=>"UC_ARCH_MIPS", macro=>"1"},
              {name=>"UC_ARCH_X86", macro=>"1"},
              {name=>"UC_ARCH_PPC", macro=>"1"},
              {name=>"UC_ARCH_SPARC", macro=>"1"},
              {name=>"UC_ARCH_M68K", macro=>"1"},
              {name=>"UC_ARCH_MAX", macro=>"1"},

              {name=>"UC_ERR_OK", macro=>"1"},
              {name=>"UC_ERR_NOMEM", macro=>"1"},
              {name=>"UC_ERR_ARCH", macro=>"1"},
              {name=>"UC_ERR_HANDLE", macro=>"1"},
              {name=>"UC_ERR_MODE", macro=>"1"},
              {name=>"UC_ERR_VERSION", macro=>"1"},
              {name=>"UC_ERR_READ_UNMAPPED", macro=>"1"},
              {name=>"UC_ERR_WRITE_UNMAPPED", macro=>"1"},
              {name=>"UC_ERR_FETCH_UNMAPPED", macro=>"1"},
              {name=>"UC_ERR_HOOK", macro=>"1"},
              {name=>"UC_ERR_INSN_INVALID", macro=>"1"},
              {name=>"UC_ERR_MAP", macro=>"1"},
              {name=>"UC_ERR_WRITE_PROT", macro=>"1"},
              {name=>"UC_ERR_READ_PROT", macro=>"1"},
              {name=>"UC_ERR_FETCH_PROT", macro=>"1"},
              {name=>"UC_ERR_ARG", macro=>"1"},
              {name=>"UC_ERR_READ_UNALIGNED", macro=>"1"},
              {name=>"UC_ERR_WRITE_UNALIGNED", macro=>"1"},
              {name=>"UC_ERR_FETCH_UNALIGNED", macro=>"1"},
              {name=>"UC_ERR_HOOK_EXIST", macro=>"1"},
              {name=>"UC_ERR_RESOURCE", macro=>"1"},
              {name=>"UC_ERR_EXCEPTION", macro=>"1"},

              {name=>"UC_HOOK_INTR", macro=>"1"},
              {name=>"UC_HOOK_INSN", macro=>"1"},
              {name=>"UC_HOOK_CODE", macro=>"1"},
              {name=>"UC_HOOK_BLOCK", macro=>"1"},
              {name=>"UC_HOOK_MEM_READ_UNMAPPED", macro=>"1"},
              {name=>"UC_HOOK_MEM_WRITE_UNMAPPED", macro=>"1"},
              {name=>"UC_HOOK_MEM_FETCH_UNMAPPED", macro=>"1"},
              {name=>"UC_HOOK_MEM_READ_PROT", macro=>"1"},
              {name=>"UC_HOOK_MEM_WRITE_PROT", macro=>"1"},
              {name=>"UC_HOOK_MEM_FETCH_PROT", macro=>"1"},
              {name=>"UC_HOOK_MEM_READ", macro=>"1"},
              {name=>"UC_HOOK_MEM_WRITE", macro=>"1"},
              {name=>"UC_HOOK_MEM_FETCH", macro=>"1"},

              {name=>"UC_MEM_READ", macro=>"1"},
              {name=>"UC_MEM_WRITE", macro=>"1"},
              {name=>"UC_MEM_FETCH", macro=>"1"},
              {name=>"UC_MEM_READ_UNMAPPED", macro=>"1"},
              {name=>"UC_MEM_WRITE_UNMAPPED", macro=>"1"},
              {name=>"UC_MEM_FETCH_UNMAPPED", macro=>"1"},
              {name=>"UC_MEM_WRITE_PROT", macro=>"1"},
              {name=>"UC_MEM_READ_PROT", macro=>"1"},
              {name=>"UC_MEM_FETCH_PROT", macro=>"1"},

              {name=>"UC_MODE_LITTLE_ENDIAN", macro=>"1"},
              {name=>"UC_MODE_BIG_ENDIAN", macro=>"1"},
              {name=>"UC_MODE_ARM", macro=>"1"},
              {name=>"UC_MODE_THUMB", macro=>"1"},
              {name=>"UC_MODE_MCLASS", macro=>"1"},
              {name=>"UC_MODE_V8", macro=>"1"},
              {name=>"UC_MODE_MICRO", macro=>"1"},
              {name=>"UC_MODE_MIPS3", macro=>"1"},
              {name=>"UC_MODE_MIPS32R6", macro=>"1"},
              {name=>"UC_MODE_MIPS32", macro=>"1"},
              {name=>"UC_MODE_MIPS64", macro=>"1"},
              {name=>"UC_MODE_16", macro=>"1"},
              {name=>"UC_MODE_32", macro=>"1"},
              {name=>"UC_MODE_64", macro=>"1"},
              {name=>"UC_MODE_PPC32", macro=>"1"},
              {name=>"UC_MODE_PPC64", macro=>"1"},
              {name=>"UC_MODE_QPX", macro=>"1"},
              {name=>"UC_MODE_SPARC32", macro=>"1"},
              {name=>"UC_MODE_SPARC64", macro=>"1"},
              {name=>"UC_MODE_V9", macro=>"1"},
              {name=>"UC_PROT_NONE", macro=>"1"},
              {name=>"UC_PROT_READ", macro=>"1"},
              {name=>"UC_PROT_WRITE", macro=>"1"},
              {name=>"UC_PROT_EXEC", macro=>"1"},
              {name=>"UC_PROT_ALL", macro=>"1"},
              {name=>"UC_QUERY_MODE", macro=>"1"},
              {name=>"UC_QUERY_PAGE_SIZE", macro=>"1"},
              {name=>"UC_HOOK_MEM_UNMAPPED", macro=>"1"},
              {name=>"UC_HOOK_MEM_READ_INVALID", macro=>"1"},
              {name=>"UC_HOOK_MEM_WRITE_INVALID", macro=>"1"},
              {name=>"UC_HOOK_MEM_FETCH_INVALID", macro=>"1"},
              {name=>"UC_HOOK_MEM_INVALID", macro=>"1"},
              {name=>"UC_HOOK_MEM_VALID", macro=>"1"},
	{name=>"UC_X86_REG_AH", macro=>"1"}, {name=>"UC_X86_REG_AL", macro=>"1"}, {name=>"UC_X86_REG_AX", macro=>"1"}, {name=>"UC_X86_REG_BH", macro=>"1"}, {name=>"UC_X86_REG_BL", macro=>"1"},
	{name=>"UC_X86_REG_BP", macro=>"1"}, {name=>"UC_X86_REG_BPL", macro=>"1"}, {name=>"UC_X86_REG_BX", macro=>"1"}, {name=>"UC_X86_REG_CH", macro=>"1"}, {name=>"UC_X86_REG_CL", macro=>"1"},
	{name=>"UC_X86_REG_CS", macro=>"1"}, {name=>"UC_X86_REG_CX", macro=>"1"}, {name=>"UC_X86_REG_DH", macro=>"1"}, {name=>"UC_X86_REG_DI", macro=>"1"}, {name=>"UC_X86_REG_DIL", macro=>"1"},
	{name=>"UC_X86_REG_DL", macro=>"1"}, {name=>"UC_X86_REG_DS", macro=>"1"}, {name=>"UC_X86_REG_DX", macro=>"1"}, {name=>"UC_X86_REG_EAX", macro=>"1"}, {name=>"UC_X86_REG_EBP", macro=>"1"},
	{name=>"UC_X86_REG_EBX", macro=>"1"}, {name=>"UC_X86_REG_ECX", macro=>"1"}, {name=>"UC_X86_REG_EDI", macro=>"1"}, {name=>"UC_X86_REG_EDX", macro=>"1"}, {name=>"UC_X86_REG_EFLAGS", macro=>"1"},
	{name=>"UC_X86_REG_EIP", macro=>"1"}, {name=>"UC_X86_REG_EIZ", macro=>"1"}, {name=>"UC_X86_REG_ES", macro=>"1"}, {name=>"UC_X86_REG_ESI", macro=>"1"}, {name=>"UC_X86_REG_ESP", macro=>"1"},
	{name=>"UC_X86_REG_FPSW", macro=>"1"}, {name=>"UC_X86_REG_FS", macro=>"1"}, {name=>"UC_X86_REG_GS", macro=>"1"}, {name=>"UC_X86_REG_IP", macro=>"1"}, {name=>"UC_X86_REG_RAX", macro=>"1"},
	{name=>"UC_X86_REG_RBP", macro=>"1"}, {name=>"UC_X86_REG_RBX", macro=>"1"}, {name=>"UC_X86_REG_RCX", macro=>"1"}, {name=>"UC_X86_REG_RDI", macro=>"1"}, {name=>"UC_X86_REG_RDX", macro=>"1"},
	{name=>"UC_X86_REG_RIP", macro=>"1"}, {name=>"UC_X86_REG_RIZ", macro=>"1"}, {name=>"UC_X86_REG_RSI", macro=>"1"}, {name=>"UC_X86_REG_RSP", macro=>"1"}, {name=>"UC_X86_REG_SI", macro=>"1"},
	{name=>"UC_X86_REG_SIL", macro=>"1"}, {name=>"UC_X86_REG_SP", macro=>"1"}, {name=>"UC_X86_REG_SPL", macro=>"1"}, {name=>"UC_X86_REG_SS", macro=>"1"}, {name=>"UC_X86_REG_CR0", macro=>"1"},
	{name=>"UC_X86_REG_CR1", macro=>"1"}, {name=>"UC_X86_REG_CR2", macro=>"1"}, {name=>"UC_X86_REG_CR3", macro=>"1"}, {name=>"UC_X86_REG_CR4", macro=>"1"}, {name=>"UC_X86_REG_CR5", macro=>"1"},
	{name=>"UC_X86_REG_CR6", macro=>"1"}, {name=>"UC_X86_REG_CR7", macro=>"1"}, {name=>"UC_X86_REG_CR8", macro=>"1"}, {name=>"UC_X86_REG_CR9", macro=>"1"}, {name=>"UC_X86_REG_CR10", macro=>"1"},
	{name=>"UC_X86_REG_CR11", macro=>"1"}, {name=>"UC_X86_REG_CR12", macro=>"1"}, {name=>"UC_X86_REG_CR13", macro=>"1"}, {name=>"UC_X86_REG_CR14", macro=>"1"}, {name=>"UC_X86_REG_CR15", macro=>"1"},
	{name=>"UC_X86_REG_DR0", macro=>"1"}, {name=>"UC_X86_REG_DR1", macro=>"1"}, {name=>"UC_X86_REG_DR2", macro=>"1"}, {name=>"UC_X86_REG_DR3", macro=>"1"}, {name=>"UC_X86_REG_DR4", macro=>"1"},
	{name=>"UC_X86_REG_DR5", macro=>"1"}, {name=>"UC_X86_REG_DR6", macro=>"1"}, {name=>"UC_X86_REG_DR7", macro=>"1"}, {name=>"UC_X86_REG_DR8", macro=>"1"}, {name=>"UC_X86_REG_DR9", macro=>"1"},
	{name=>"UC_X86_REG_DR10", macro=>"1"}, {name=>"UC_X86_REG_DR11", macro=>"1"}, {name=>"UC_X86_REG_DR12", macro=>"1"}, {name=>"UC_X86_REG_DR13", macro=>"1"}, {name=>"UC_X86_REG_DR14", macro=>"1"},
	{name=>"UC_X86_REG_DR15", macro=>"1"}, {name=>"UC_X86_REG_FP0", macro=>"1"}, {name=>"UC_X86_REG_FP1", macro=>"1"}, {name=>"UC_X86_REG_FP2", macro=>"1"}, {name=>"UC_X86_REG_FP3", macro=>"1"},
	{name=>"UC_X86_REG_FP4", macro=>"1"}, {name=>"UC_X86_REG_FP5", macro=>"1"}, {name=>"UC_X86_REG_FP6", macro=>"1"}, {name=>"UC_X86_REG_FP7", macro=>"1"},
	{name=>"UC_X86_REG_K0", macro=>"1"}, {name=>"UC_X86_REG_K1", macro=>"1"}, {name=>"UC_X86_REG_K2", macro=>"1"}, {name=>"UC_X86_REG_K3", macro=>"1"}, {name=>"UC_X86_REG_K4", macro=>"1"},
	{name=>"UC_X86_REG_K5", macro=>"1"}, {name=>"UC_X86_REG_K6", macro=>"1"}, {name=>"UC_X86_REG_K7", macro=>"1"}, {name=>"UC_X86_REG_MM0", macro=>"1"}, {name=>"UC_X86_REG_MM1", macro=>"1"},
	{name=>"UC_X86_REG_MM2", macro=>"1"}, {name=>"UC_X86_REG_MM3", macro=>"1"}, {name=>"UC_X86_REG_MM4", macro=>"1"}, {name=>"UC_X86_REG_MM5", macro=>"1"}, {name=>"UC_X86_REG_MM6", macro=>"1"},
	{name=>"UC_X86_REG_MM7", macro=>"1"}, {name=>"UC_X86_REG_R8", macro=>"1"}, {name=>"UC_X86_REG_R9", macro=>"1"}, {name=>"UC_X86_REG_R10", macro=>"1"}, {name=>"UC_X86_REG_R11", macro=>"1"},
	{name=>"UC_X86_REG_R12", macro=>"1"}, {name=>"UC_X86_REG_R13", macro=>"1"}, {name=>"UC_X86_REG_R14", macro=>"1"}, {name=>"UC_X86_REG_R15", macro=>"1"},
	{name=>"UC_X86_REG_ST0", macro=>"1"}, {name=>"UC_X86_REG_ST1", macro=>"1"}, {name=>"UC_X86_REG_ST2", macro=>"1"}, {name=>"UC_X86_REG_ST3", macro=>"1"},
	{name=>"UC_X86_REG_ST4", macro=>"1"}, {name=>"UC_X86_REG_ST5", macro=>"1"}, {name=>"UC_X86_REG_ST6", macro=>"1"}, {name=>"UC_X86_REG_ST7", macro=>"1"},
	{name=>"UC_X86_REG_XMM0", macro=>"1"}, {name=>"UC_X86_REG_XMM1", macro=>"1"}, {name=>"UC_X86_REG_XMM2", macro=>"1"}, {name=>"UC_X86_REG_XMM3", macro=>"1"}, {name=>"UC_X86_REG_XMM4", macro=>"1"},
	{name=>"UC_X86_REG_XMM5", macro=>"1"}, {name=>"UC_X86_REG_XMM6", macro=>"1"}, {name=>"UC_X86_REG_XMM7", macro=>"1"}, {name=>"UC_X86_REG_XMM8", macro=>"1"}, {name=>"UC_X86_REG_XMM9", macro=>"1"},
	{name=>"UC_X86_REG_XMM10", macro=>"1"}, {name=>"UC_X86_REG_XMM11", macro=>"1"}, {name=>"UC_X86_REG_XMM12", macro=>"1"}, {name=>"UC_X86_REG_XMM13", macro=>"1"}, {name=>"UC_X86_REG_XMM14", macro=>"1"},
	{name=>"UC_X86_REG_XMM15", macro=>"1"}, {name=>"UC_X86_REG_XMM16", macro=>"1"}, {name=>"UC_X86_REG_XMM17", macro=>"1"}, {name=>"UC_X86_REG_XMM18", macro=>"1"}, {name=>"UC_X86_REG_XMM19", macro=>"1"},
	{name=>"UC_X86_REG_XMM20", macro=>"1"}, {name=>"UC_X86_REG_XMM21", macro=>"1"}, {name=>"UC_X86_REG_XMM22", macro=>"1"}, {name=>"UC_X86_REG_XMM23", macro=>"1"}, {name=>"UC_X86_REG_XMM24", macro=>"1"},
	{name=>"UC_X86_REG_XMM25", macro=>"1"}, {name=>"UC_X86_REG_XMM26", macro=>"1"}, {name=>"UC_X86_REG_XMM27", macro=>"1"}, {name=>"UC_X86_REG_XMM28", macro=>"1"}, {name=>"UC_X86_REG_XMM29", macro=>"1"},
	{name=>"UC_X86_REG_XMM30", macro=>"1"}, {name=>"UC_X86_REG_XMM31", macro=>"1"}, {name=>"UC_X86_REG_YMM0", macro=>"1"}, {name=>"UC_X86_REG_YMM1", macro=>"1"}, {name=>"UC_X86_REG_YMM2", macro=>"1"},
	{name=>"UC_X86_REG_YMM3", macro=>"1"}, {name=>"UC_X86_REG_YMM4", macro=>"1"}, {name=>"UC_X86_REG_YMM5", macro=>"1"}, {name=>"UC_X86_REG_YMM6", macro=>"1"}, {name=>"UC_X86_REG_YMM7", macro=>"1"},
	{name=>"UC_X86_REG_YMM8", macro=>"1"}, {name=>"UC_X86_REG_YMM9", macro=>"1"}, {name=>"UC_X86_REG_YMM10", macro=>"1"}, {name=>"UC_X86_REG_YMM11", macro=>"1"}, {name=>"UC_X86_REG_YMM12", macro=>"1"},
	{name=>"UC_X86_REG_YMM13", macro=>"1"}, {name=>"UC_X86_REG_YMM14", macro=>"1"}, {name=>"UC_X86_REG_YMM15", macro=>"1"}, {name=>"UC_X86_REG_YMM16", macro=>"1"}, {name=>"UC_X86_REG_YMM17", macro=>"1"},
	{name=>"UC_X86_REG_YMM18", macro=>"1"}, {name=>"UC_X86_REG_YMM19", macro=>"1"}, {name=>"UC_X86_REG_YMM20", macro=>"1"}, {name=>"UC_X86_REG_YMM21", macro=>"1"}, {name=>"UC_X86_REG_YMM22", macro=>"1"},
	{name=>"UC_X86_REG_YMM23", macro=>"1"}, {name=>"UC_X86_REG_YMM24", macro=>"1"}, {name=>"UC_X86_REG_YMM25", macro=>"1"}, {name=>"UC_X86_REG_YMM26", macro=>"1"}, {name=>"UC_X86_REG_YMM27", macro=>"1"},
	{name=>"UC_X86_REG_YMM28", macro=>"1"}, {name=>"UC_X86_REG_YMM29", macro=>"1"}, {name=>"UC_X86_REG_YMM30", macro=>"1"}, {name=>"UC_X86_REG_YMM31", macro=>"1"}, {name=>"UC_X86_REG_ZMM0", macro=>"1"},
	{name=>"UC_X86_REG_ZMM1", macro=>"1"}, {name=>"UC_X86_REG_ZMM2", macro=>"1"}, {name=>"UC_X86_REG_ZMM3", macro=>"1"}, {name=>"UC_X86_REG_ZMM4", macro=>"1"}, {name=>"UC_X86_REG_ZMM5", macro=>"1"},
	{name=>"UC_X86_REG_ZMM6", macro=>"1"}, {name=>"UC_X86_REG_ZMM7", macro=>"1"}, {name=>"UC_X86_REG_ZMM8", macro=>"1"}, {name=>"UC_X86_REG_ZMM9", macro=>"1"}, {name=>"UC_X86_REG_ZMM10", macro=>"1"},
	{name=>"UC_X86_REG_ZMM11", macro=>"1"}, {name=>"UC_X86_REG_ZMM12", macro=>"1"}, {name=>"UC_X86_REG_ZMM13", macro=>"1"}, {name=>"UC_X86_REG_ZMM14", macro=>"1"}, {name=>"UC_X86_REG_ZMM15", macro=>"1"},
	{name=>"UC_X86_REG_ZMM16", macro=>"1"}, {name=>"UC_X86_REG_ZMM17", macro=>"1"}, {name=>"UC_X86_REG_ZMM18", macro=>"1"}, {name=>"UC_X86_REG_ZMM19", macro=>"1"}, {name=>"UC_X86_REG_ZMM20", macro=>"1"},
	{name=>"UC_X86_REG_ZMM21", macro=>"1"}, {name=>"UC_X86_REG_ZMM22", macro=>"1"}, {name=>"UC_X86_REG_ZMM23", macro=>"1"}, {name=>"UC_X86_REG_ZMM24", macro=>"1"}, {name=>"UC_X86_REG_ZMM25", macro=>"1"},
	{name=>"UC_X86_REG_ZMM26", macro=>"1"}, {name=>"UC_X86_REG_ZMM27", macro=>"1"}, {name=>"UC_X86_REG_ZMM28", macro=>"1"}, {name=>"UC_X86_REG_ZMM29", macro=>"1"}, {name=>"UC_X86_REG_ZMM30", macro=>"1"},
	{name=>"UC_X86_REG_ZMM31", macro=>"1"}, {name=>"UC_X86_REG_R8B", macro=>"1"}, {name=>"UC_X86_REG_R9B", macro=>"1"}, {name=>"UC_X86_REG_R10B", macro=>"1"}, {name=>"UC_X86_REG_R11B", macro=>"1"},
	{name=>"UC_X86_REG_R12B", macro=>"1"}, {name=>"UC_X86_REG_R13B", macro=>"1"}, {name=>"UC_X86_REG_R14B", macro=>"1"}, {name=>"UC_X86_REG_R15B", macro=>"1"}, {name=>"UC_X86_REG_R8D", macro=>"1"},
	{name=>"UC_X86_REG_R9D", macro=>"1"}, {name=>"UC_X86_REG_R10D", macro=>"1"}, {name=>"UC_X86_REG_R11D", macro=>"1"}, {name=>"UC_X86_REG_R12D", macro=>"1"}, {name=>"UC_X86_REG_R13D", macro=>"1"},
	{name=>"UC_X86_REG_R14D", macro=>"1"}, {name=>"UC_X86_REG_R15D", macro=>"1"}, {name=>"UC_X86_REG_R8W", macro=>"1"}, {name=>"UC_X86_REG_R9W", macro=>"1"}, {name=>"UC_X86_REG_R10W", macro=>"1"},
	{name=>"UC_X86_REG_R11W", macro=>"1"}, {name=>"UC_X86_REG_R12W", macro=>"1"}, {name=>"UC_X86_REG_R13W", macro=>"1"}, {name=>"UC_X86_REG_R14W", macro=>"1"}, {name=>"UC_X86_REG_R15W", macro=>"1"},
	{name=>"UC_X86_REG_IDTR", macro=>"1"}, {name=>"UC_X86_REG_GDTR", macro=>"1"}, {name=>"UC_X86_REG_LDTR", macro=>"1"}, {name=>"UC_X86_REG_TR", macro=>"1"}, {name=>"UC_X86_REG_FPCW", macro=>"1"},
	{name=>"UC_X86_REG_FPTAG", macro=>"1"},
	{name=>"UC_ARM_REG_APSR", macro=>"1"},
    { name => "UC_ARM_REG_APSR_NZCV", macro => "1" },
	{name=>"UC_ARM_REG_CPSR", macro=>"1"},
	{name=>"UC_ARM_REG_FPEXC", macro=>"1"},
	{name=>"UC_ARM_REG_FPINST", macro=>"1"},
	{name=>"UC_ARM_REG_FPSCR", macro=>"1"},
    {name => "UC_ARM_REG_FPSCR_NZCV", macro => "1" },
	{name=>"UC_ARM_REG_FPSID", macro=>"1"},
	{name=>"UC_ARM_REG_ITSTATE", macro=>"1"},
	{name=>"UC_ARM_REG_LR", macro=>"1"},
	{name=>"UC_ARM_REG_PC", macro=>"1"},
	{name=>"UC_ARM_REG_SP", macro=>"1"},
	{name=>"UC_ARM_REG_SPSR", macro=>"1"},
	{name=>"UC_ARM_REG_D0", macro=>"1"},
	{name=>"UC_ARM_REG_D1", macro=>"1"},
	{name=>"UC_ARM_REG_D2", macro=>"1"},
	{name=>"UC_ARM_REG_D3", macro=>"1"},
	{name=>"UC_ARM_REG_D4", macro=>"1"},
	{name=>"UC_ARM_REG_D5", macro=>"1"},
	{name=>"UC_ARM_REG_D6", macro=>"1"},
	{name=>"UC_ARM_REG_D7", macro=>"1"},
	{name=>"UC_ARM_REG_D8", macro=>"1"},
	{name=>"UC_ARM_REG_D9", macro=>"1"},
	{name=>"UC_ARM_REG_D10", macro=>"1"},
	{name=>"UC_ARM_REG_D11", macro=>"1"},
	{name=>"UC_ARM_REG_D12", macro=>"1"},
	{name=>"UC_ARM_REG_D13", macro=>"1"},
	{name=>"UC_ARM_REG_D14", macro=>"1"},
	{name=>"UC_ARM_REG_D15", macro=>"1"},
	{name=>"UC_ARM_REG_D16", macro=>"1"},
	{name=>"UC_ARM_REG_D17", macro=>"1"},
	{name=>"UC_ARM_REG_D18", macro=>"1"},
	{name=>"UC_ARM_REG_D19", macro=>"1"},
	{name=>"UC_ARM_REG_D20", macro=>"1"},
	{name=>"UC_ARM_REG_D21", macro=>"1"},
	{name=>"UC_ARM_REG_D22", macro=>"1"},
	{name=>"UC_ARM_REG_D23", macro=>"1"},
	{name=>"UC_ARM_REG_D24", macro=>"1"},
	{name=>"UC_ARM_REG_D25", macro=>"1"},
	{name=>"UC_ARM_REG_D26", macro=>"1"},
	{name=>"UC_ARM_REG_D27", macro=>"1"},
	{name=>"UC_ARM_REG_D28", macro=>"1"},
	{name=>"UC_ARM_REG_D29", macro=>"1"},
	{name=>"UC_ARM_REG_D30", macro=>"1"},
	{name=>"UC_ARM_REG_D31", macro=>"1"},
	{name=>"UC_ARM_REG_FPINST2", macro=>"1"},
	{name=>"UC_ARM_REG_MVFR0", macro=>"1"},
	{name=>"UC_ARM_REG_MVFR1", macro=>"1"},
	{name=>"UC_ARM_REG_MVFR2", macro=>"1"},
	{name=>"UC_ARM_REG_Q0", macro=>"1"},
	{name=>"UC_ARM_REG_Q1", macro=>"1"},
	{name=>"UC_ARM_REG_Q2", macro=>"1"},
	{name=>"UC_ARM_REG_Q3", macro=>"1"},
	{name=>"UC_ARM_REG_Q4", macro=>"1"},
	{name=>"UC_ARM_REG_Q5", macro=>"1"},
	{name=>"UC_ARM_REG_Q6", macro=>"1"},
	{name=>"UC_ARM_REG_Q7", macro=>"1"},
	{name=>"UC_ARM_REG_Q8", macro=>"1"},
	{name=>"UC_ARM_REG_Q9", macro=>"1"},
	{name=>"UC_ARM_REG_Q10", macro=>"1"},
	{name=>"UC_ARM_REG_Q11", macro=>"1"},
	{name=>"UC_ARM_REG_Q12", macro=>"1"},
	{name=>"UC_ARM_REG_Q13", macro=>"1"},
	{name=>"UC_ARM_REG_Q14", macro=>"1"},
	{name=>"UC_ARM_REG_Q15", macro=>"1"},
	{name=>"UC_ARM_REG_R0", macro=>"1"},
	{name=>"UC_ARM_REG_R1", macro=>"1"},
	{name=>"UC_ARM_REG_R2", macro=>"1"},
	{name=>"UC_ARM_REG_R3", macro=>"1"},
	{name=>"UC_ARM_REG_R4", macro=>"1"},
	{name=>"UC_ARM_REG_R5", macro=>"1"},
	{name=>"UC_ARM_REG_R6", macro=>"1"},
	{name=>"UC_ARM_REG_R7", macro=>"1"},
	{name=>"UC_ARM_REG_R8", macro=>"1"},
	{name=>"UC_ARM_REG_R9", macro=>"1"},
	{name=>"UC_ARM_REG_R10", macro=>"1"},
	{name=>"UC_ARM_REG_R11", macro=>"1"},
	{name=>"UC_ARM_REG_R12", macro=>"1"},
	{name=>"UC_ARM_REG_S0", macro=>"1"},
	{name=>"UC_ARM_REG_S1", macro=>"1"},
	{name=>"UC_ARM_REG_S2", macro=>"1"},
	{name=>"UC_ARM_REG_S3", macro=>"1"},
	{name=>"UC_ARM_REG_S4", macro=>"1"},
	{name=>"UC_ARM_REG_S5", macro=>"1"},
	{name=>"UC_ARM_REG_S6", macro=>"1"},
	{name=>"UC_ARM_REG_S7", macro=>"1"},
	{name=>"UC_ARM_REG_S8", macro=>"1"},
	{name=>"UC_ARM_REG_S9", macro=>"1"},
	{name=>"UC_ARM_REG_S10", macro=>"1"},
	{name=>"UC_ARM_REG_S11", macro=>"1"},
	{name=>"UC_ARM_REG_S12", macro=>"1"},
	{name=>"UC_ARM_REG_S13", macro=>"1"},
	{name=>"UC_ARM_REG_S14", macro=>"1"},
	{name=>"UC_ARM_REG_S15", macro=>"1"},
	{name=>"UC_ARM_REG_S16", macro=>"1"},
	{name=>"UC_ARM_REG_S17", macro=>"1"},
	{name=>"UC_ARM_REG_S18", macro=>"1"},
	{name=>"UC_ARM_REG_S19", macro=>"1"},
	{name=>"UC_ARM_REG_S20", macro=>"1"},
	{name=>"UC_ARM_REG_S21", macro=>"1"},
	{name=>"UC_ARM_REG_S22", macro=>"1"},
	{name=>"UC_ARM_REG_S23", macro=>"1"},
	{name=>"UC_ARM_REG_S24", macro=>"1"},
	{name=>"UC_ARM_REG_S25", macro=>"1"},
	{name=>"UC_ARM_REG_S26", macro=>"1"},
	{name=>"UC_ARM_REG_S27", macro=>"1"},
	{name=>"UC_ARM_REG_S28", macro=>"1"},
	{name=>"UC_ARM_REG_S29", macro=>"1"},
	{name=>"UC_ARM_REG_S30", macro=>"1"},
	{name=>"UC_ARM_REG_S31", macro=>"1"},
	{name=>"UC_ARM_REG_R13", macro=>"1"},
	{name=>"UC_ARM_REG_R14", macro=>"1"},
	{name=>"UC_ARM_REG_R15", macro=>"1"},
	{name=>"UC_ARM_REG_SB", macro=>"1"},
	{name=>"UC_ARM_REG_SL", macro=>"1"},
	{name=>"UC_ARM_REG_FP", macro=>"1"},
	{name=>"UC_ARM_REG_IP", macro=>"1"},
	{name=>"UC_SPARC_REG_F0", macro=>"1"},
	{name=>"UC_SPARC_REG_F1", macro=>"1"},
	{name=>"UC_SPARC_REG_F2", macro=>"1"},
	{name=>"UC_SPARC_REG_F3", macro=>"1"},
	{name=>"UC_SPARC_REG_F4", macro=>"1"},
	{name=>"UC_SPARC_REG_F5", macro=>"1"},
	{name=>"UC_SPARC_REG_F6", macro=>"1"},
	{name=>"UC_SPARC_REG_F7", macro=>"1"},
	{name=>"UC_SPARC_REG_F8", macro=>"1"},
	{name=>"UC_SPARC_REG_F9", macro=>"1"},
	{name=>"UC_SPARC_REG_F10", macro=>"1"},
	{name=>"UC_SPARC_REG_F11", macro=>"1"},
	{name=>"UC_SPARC_REG_F12", macro=>"1"},
	{name=>"UC_SPARC_REG_F13", macro=>"1"},
	{name=>"UC_SPARC_REG_F14", macro=>"1"},
	{name=>"UC_SPARC_REG_F15", macro=>"1"},
	{name=>"UC_SPARC_REG_F16", macro=>"1"},
	{name=>"UC_SPARC_REG_F17", macro=>"1"},
	{name=>"UC_SPARC_REG_F18", macro=>"1"},
	{name=>"UC_SPARC_REG_F19", macro=>"1"},
	{name=>"UC_SPARC_REG_F20", macro=>"1"},
	{name=>"UC_SPARC_REG_F21", macro=>"1"},
	{name=>"UC_SPARC_REG_F22", macro=>"1"},
	{name=>"UC_SPARC_REG_F23", macro=>"1"},
	{name=>"UC_SPARC_REG_F24", macro=>"1"},
	{name=>"UC_SPARC_REG_F25", macro=>"1"},
	{name=>"UC_SPARC_REG_F26", macro=>"1"},
	{name=>"UC_SPARC_REG_F27", macro=>"1"},
	{name=>"UC_SPARC_REG_F28", macro=>"1"},
	{name=>"UC_SPARC_REG_F29", macro=>"1"},
	{name=>"UC_SPARC_REG_F30", macro=>"1"},
	{name=>"UC_SPARC_REG_F31", macro=>"1"},
	{name=>"UC_SPARC_REG_F32", macro=>"1"},
	{name=>"UC_SPARC_REG_F34", macro=>"1"},
	{name=>"UC_SPARC_REG_F36", macro=>"1"},
	{name=>"UC_SPARC_REG_F38", macro=>"1"},
	{name=>"UC_SPARC_REG_F40", macro=>"1"},
	{name=>"UC_SPARC_REG_F42", macro=>"1"},
	{name=>"UC_SPARC_REG_F44", macro=>"1"},
	{name=>"UC_SPARC_REG_F46", macro=>"1"},
	{name=>"UC_SPARC_REG_F48", macro=>"1"},
	{name=>"UC_SPARC_REG_F50", macro=>"1"},
	{name=>"UC_SPARC_REG_F52", macro=>"1"},
	{name=>"UC_SPARC_REG_F54", macro=>"1"},
	{name=>"UC_SPARC_REG_F56", macro=>"1"},
	{name=>"UC_SPARC_REG_F58", macro=>"1"},
	{name=>"UC_SPARC_REG_F60", macro=>"1"},
	{name=>"UC_SPARC_REG_F62", macro=>"1"},
	{name=>"UC_SPARC_REG_FCC0", macro=>"1"},
	{name=>"UC_SPARC_REG_FCC1", macro=>"1"},
	{name=>"UC_SPARC_REG_FCC2", macro=>"1"},
	{name=>"UC_SPARC_REG_FCC3", macro=>"1"},
	{name=>"UC_SPARC_REG_G0", macro=>"1"},
	{name=>"UC_SPARC_REG_G1", macro=>"1"},
	{name=>"UC_SPARC_REG_G2", macro=>"1"},
	{name=>"UC_SPARC_REG_G3", macro=>"1"},
	{name=>"UC_SPARC_REG_G4", macro=>"1"},
	{name=>"UC_SPARC_REG_G5", macro=>"1"},
	{name=>"UC_SPARC_REG_G6", macro=>"1"},
	{name=>"UC_SPARC_REG_G7", macro=>"1"},
	{name=>"UC_SPARC_REG_I0", macro=>"1"},
	{name=>"UC_SPARC_REG_I1", macro=>"1"},
	{name=>"UC_SPARC_REG_I2", macro=>"1"},
	{name=>"UC_SPARC_REG_I3", macro=>"1"},
	{name=>"UC_SPARC_REG_I4", macro=>"1"},
	{name=>"UC_SPARC_REG_I5", macro=>"1"},
	{name=>"UC_SPARC_REG_FP", macro=>"1"},
	{name=>"UC_SPARC_REG_I7", macro=>"1"},
	{name=>"UC_SPARC_REG_ICC", macro=>"1"},
	{name=>"UC_SPARC_REG_L0", macro=>"1"},
	{name=>"UC_SPARC_REG_L1", macro=>"1"},
	{name=>"UC_SPARC_REG_L2", macro=>"1"},
	{name=>"UC_SPARC_REG_L3", macro=>"1"},
	{name=>"UC_SPARC_REG_L4", macro=>"1"},
	{name=>"UC_SPARC_REG_L5", macro=>"1"},
	{name=>"UC_SPARC_REG_L6", macro=>"1"},
	{name=>"UC_SPARC_REG_L7", macro=>"1"},
	{name=>"UC_SPARC_REG_O0", macro=>"1"},
	{name=>"UC_SPARC_REG_O1", macro=>"1"},
	{name=>"UC_SPARC_REG_O2", macro=>"1"},
	{name=>"UC_SPARC_REG_O3", macro=>"1"},
	{name=>"UC_SPARC_REG_O4", macro=>"1"},
	{name=>"UC_SPARC_REG_O5", macro=>"1"},
	{name=>"UC_SPARC_REG_SP", macro=>"1"},
	{name=>"UC_SPARC_REG_O7", macro=>"1"},
	{name=>"UC_SPARC_REG_Y", macro=>"1"},
	{name=>"UC_SPARC_REG_XCC", macro=>"1"},
	{name=>"UC_SPARC_REG_PC", macro=>"1"},
    { name => "UC_SPARC_REG_O6", macro => "1"},
    { name =>  "UC_SPARC_REG_I6", macro => "1"},
	{name=>"UC_ARM64_REG_X29", macro=>"1"},
	{name=>"UC_ARM64_REG_X30", macro=>"1"},
	{name=>"UC_ARM64_REG_NZCV", macro=>"1"},
	{name=>"UC_ARM64_REG_SP", macro=>"1"},
	{name=>"UC_ARM64_REG_WSP", macro=>"1"},
	{name=>"UC_ARM64_REG_WZR", macro=>"1"},
	{name=>"UC_ARM64_REG_XZR", macro=>"1"},
	{name=>"UC_ARM64_REG_B0", macro=>"1"},
	{name=>"UC_ARM64_REG_B1", macro=>"1"},
	{name=>"UC_ARM64_REG_B2", macro=>"1"},
	{name=>"UC_ARM64_REG_B3", macro=>"1"},
	{name=>"UC_ARM64_REG_B4", macro=>"1"},
	{name=>"UC_ARM64_REG_B5", macro=>"1"},
	{name=>"UC_ARM64_REG_B6", macro=>"1"},
	{name=>"UC_ARM64_REG_B7", macro=>"1"},
	{name=>"UC_ARM64_REG_B8", macro=>"1"},
	{name=>"UC_ARM64_REG_B9", macro=>"1"},
	{name=>"UC_ARM64_REG_B10", macro=>"1"},
	{name=>"UC_ARM64_REG_B11", macro=>"1"},
	{name=>"UC_ARM64_REG_B12", macro=>"1"},
	{name=>"UC_ARM64_REG_B13", macro=>"1"},
	{name=>"UC_ARM64_REG_B14", macro=>"1"},
	{name=>"UC_ARM64_REG_B15", macro=>"1"},
	{name=>"UC_ARM64_REG_B16", macro=>"1"},
	{name=>"UC_ARM64_REG_B17", macro=>"1"},
	{name=>"UC_ARM64_REG_B18", macro=>"1"},
	{name=>"UC_ARM64_REG_B19", macro=>"1"},
	{name=>"UC_ARM64_REG_B20", macro=>"1"},
	{name=>"UC_ARM64_REG_B21", macro=>"1"},
	{name=>"UC_ARM64_REG_B22", macro=>"1"},
	{name=>"UC_ARM64_REG_B23", macro=>"1"},
	{name=>"UC_ARM64_REG_B24", macro=>"1"},
	{name=>"UC_ARM64_REG_B25", macro=>"1"},
	{name=>"UC_ARM64_REG_B26", macro=>"1"},
	{name=>"UC_ARM64_REG_B27", macro=>"1"},
	{name=>"UC_ARM64_REG_B28", macro=>"1"},
	{name=>"UC_ARM64_REG_B29", macro=>"1"},
	{name=>"UC_ARM64_REG_B30", macro=>"1"},
	{name=>"UC_ARM64_REG_B31", macro=>"1"},
	{name=>"UC_ARM64_REG_D0", macro=>"1"},
	{name=>"UC_ARM64_REG_D1", macro=>"1"},
	{name=>"UC_ARM64_REG_D2", macro=>"1"},
	{name=>"UC_ARM64_REG_D3", macro=>"1"},
	{name=>"UC_ARM64_REG_D4", macro=>"1"},
	{name=>"UC_ARM64_REG_D5", macro=>"1"},
	{name=>"UC_ARM64_REG_D6", macro=>"1"},
	{name=>"UC_ARM64_REG_D7", macro=>"1"},
	{name=>"UC_ARM64_REG_D8", macro=>"1"},
	{name=>"UC_ARM64_REG_D9", macro=>"1"},
	{name=>"UC_ARM64_REG_D10", macro=>"1"},
	{name=>"UC_ARM64_REG_D11", macro=>"1"},
	{name=>"UC_ARM64_REG_D12", macro=>"1"},
	{name=>"UC_ARM64_REG_D13", macro=>"1"},
	{name=>"UC_ARM64_REG_D14", macro=>"1"},
	{name=>"UC_ARM64_REG_D15", macro=>"1"},
	{name=>"UC_ARM64_REG_D16", macro=>"1"},
	{name=>"UC_ARM64_REG_D17", macro=>"1"},
	{name=>"UC_ARM64_REG_D18", macro=>"1"},
	{name=>"UC_ARM64_REG_D19", macro=>"1"},
	{name=>"UC_ARM64_REG_D20", macro=>"1"},
	{name=>"UC_ARM64_REG_D21", macro=>"1"},
	{name=>"UC_ARM64_REG_D22", macro=>"1"},
	{name=>"UC_ARM64_REG_D23", macro=>"1"},
	{name=>"UC_ARM64_REG_D24", macro=>"1"},
	{name=>"UC_ARM64_REG_D25", macro=>"1"},
	{name=>"UC_ARM64_REG_D26", macro=>"1"},
	{name=>"UC_ARM64_REG_D27", macro=>"1"},
	{name=>"UC_ARM64_REG_D28", macro=>"1"},
	{name=>"UC_ARM64_REG_D29", macro=>"1"},
	{name=>"UC_ARM64_REG_D30", macro=>"1"},
	{name=>"UC_ARM64_REG_D31", macro=>"1"},
	{name=>"UC_ARM64_REG_H0", macro=>"1"},
	{name=>"UC_ARM64_REG_H1", macro=>"1"},
	{name=>"UC_ARM64_REG_H2", macro=>"1"},
	{name=>"UC_ARM64_REG_H3", macro=>"1"},
	{name=>"UC_ARM64_REG_H4", macro=>"1"},
	{name=>"UC_ARM64_REG_H5", macro=>"1"},
	{name=>"UC_ARM64_REG_H6", macro=>"1"},
	{name=>"UC_ARM64_REG_H7", macro=>"1"},
	{name=>"UC_ARM64_REG_H8", macro=>"1"},
	{name=>"UC_ARM64_REG_H9", macro=>"1"},
	{name=>"UC_ARM64_REG_H10", macro=>"1"},
	{name=>"UC_ARM64_REG_H11", macro=>"1"},
	{name=>"UC_ARM64_REG_H12", macro=>"1"},
	{name=>"UC_ARM64_REG_H13", macro=>"1"},
	{name=>"UC_ARM64_REG_H14", macro=>"1"},
	{name=>"UC_ARM64_REG_H15", macro=>"1"},
	{name=>"UC_ARM64_REG_H16", macro=>"1"},
	{name=>"UC_ARM64_REG_H17", macro=>"1"},
	{name=>"UC_ARM64_REG_H18", macro=>"1"},
	{name=>"UC_ARM64_REG_H19", macro=>"1"},
	{name=>"UC_ARM64_REG_H20", macro=>"1"},
	{name=>"UC_ARM64_REG_H21", macro=>"1"},
	{name=>"UC_ARM64_REG_H22", macro=>"1"},
	{name=>"UC_ARM64_REG_H23", macro=>"1"},
	{name=>"UC_ARM64_REG_H24", macro=>"1"},
	{name=>"UC_ARM64_REG_H25", macro=>"1"},
	{name=>"UC_ARM64_REG_H26", macro=>"1"},
	{name=>"UC_ARM64_REG_H27", macro=>"1"},
	{name=>"UC_ARM64_REG_H28", macro=>"1"},
	{name=>"UC_ARM64_REG_H29", macro=>"1"},
	{name=>"UC_ARM64_REG_H30", macro=>"1"},
	{name=>"UC_ARM64_REG_H31", macro=>"1"},
	{name=>"UC_ARM64_REG_Q0", macro=>"1"},
	{name=>"UC_ARM64_REG_Q1", macro=>"1"},
	{name=>"UC_ARM64_REG_Q2", macro=>"1"},
	{name=>"UC_ARM64_REG_Q3", macro=>"1"},
	{name=>"UC_ARM64_REG_Q4", macro=>"1"},
	{name=>"UC_ARM64_REG_Q5", macro=>"1"},
	{name=>"UC_ARM64_REG_Q6", macro=>"1"},
	{name=>"UC_ARM64_REG_Q7", macro=>"1"},
	{name=>"UC_ARM64_REG_Q8", macro=>"1"},
	{name=>"UC_ARM64_REG_Q9", macro=>"1"},
	{name=>"UC_ARM64_REG_Q10", macro=>"1"},
	{name=>"UC_ARM64_REG_Q11", macro=>"1"},
	{name=>"UC_ARM64_REG_Q12", macro=>"1"},
	{name=>"UC_ARM64_REG_Q13", macro=>"1"},
	{name=>"UC_ARM64_REG_Q14", macro=>"1"},
	{name=>"UC_ARM64_REG_Q15", macro=>"1"},
	{name=>"UC_ARM64_REG_Q16", macro=>"1"},
	{name=>"UC_ARM64_REG_Q17", macro=>"1"},
	{name=>"UC_ARM64_REG_Q18", macro=>"1"},
	{name=>"UC_ARM64_REG_Q19", macro=>"1"},
	{name=>"UC_ARM64_REG_Q20", macro=>"1"},
	{name=>"UC_ARM64_REG_Q21", macro=>"1"},
	{name=>"UC_ARM64_REG_Q22", macro=>"1"},
	{name=>"UC_ARM64_REG_Q23", macro=>"1"},
	{name=>"UC_ARM64_REG_Q24", macro=>"1"},
	{name=>"UC_ARM64_REG_Q25", macro=>"1"},
	{name=>"UC_ARM64_REG_Q26", macro=>"1"},
	{name=>"UC_ARM64_REG_Q27", macro=>"1"},
	{name=>"UC_ARM64_REG_Q28", macro=>"1"},
	{name=>"UC_ARM64_REG_Q29", macro=>"1"},
	{name=>"UC_ARM64_REG_Q30", macro=>"1"},
	{name=>"UC_ARM64_REG_Q31", macro=>"1"},
	{name=>"UC_ARM64_REG_S0", macro=>"1"},
	{name=>"UC_ARM64_REG_S1", macro=>"1"},
	{name=>"UC_ARM64_REG_S2", macro=>"1"},
	{name=>"UC_ARM64_REG_S3", macro=>"1"},
	{name=>"UC_ARM64_REG_S4", macro=>"1"},
	{name=>"UC_ARM64_REG_S5", macro=>"1"},
	{name=>"UC_ARM64_REG_S6", macro=>"1"},
	{name=>"UC_ARM64_REG_S7", macro=>"1"},
	{name=>"UC_ARM64_REG_S8", macro=>"1"},
	{name=>"UC_ARM64_REG_S9", macro=>"1"},
	{name=>"UC_ARM64_REG_S10", macro=>"1"},
	{name=>"UC_ARM64_REG_S11", macro=>"1"},
	{name=>"UC_ARM64_REG_S12", macro=>"1"},
	{name=>"UC_ARM64_REG_S13", macro=>"1"},
	{name=>"UC_ARM64_REG_S14", macro=>"1"},
	{name=>"UC_ARM64_REG_S15", macro=>"1"},
	{name=>"UC_ARM64_REG_S16", macro=>"1"},
	{name=>"UC_ARM64_REG_S17", macro=>"1"},
	{name=>"UC_ARM64_REG_S18", macro=>"1"},
	{name=>"UC_ARM64_REG_S19", macro=>"1"},
	{name=>"UC_ARM64_REG_S20", macro=>"1"},
	{name=>"UC_ARM64_REG_S21", macro=>"1"},
	{name=>"UC_ARM64_REG_S22", macro=>"1"},
	{name=>"UC_ARM64_REG_S23", macro=>"1"},
	{name=>"UC_ARM64_REG_S24", macro=>"1"},
	{name=>"UC_ARM64_REG_S25", macro=>"1"},
	{name=>"UC_ARM64_REG_S26", macro=>"1"},
	{name=>"UC_ARM64_REG_S27", macro=>"1"},
	{name=>"UC_ARM64_REG_S28", macro=>"1"},
	{name=>"UC_ARM64_REG_S29", macro=>"1"},
	{name=>"UC_ARM64_REG_S30", macro=>"1"},
	{name=>"UC_ARM64_REG_S31", macro=>"1"},
	{name=>"UC_ARM64_REG_W0", macro=>"1"},
	{name=>"UC_ARM64_REG_W1", macro=>"1"},
	{name=>"UC_ARM64_REG_W2", macro=>"1"},
	{name=>"UC_ARM64_REG_W3", macro=>"1"},
	{name=>"UC_ARM64_REG_W4", macro=>"1"},
	{name=>"UC_ARM64_REG_W5", macro=>"1"},
	{name=>"UC_ARM64_REG_W6", macro=>"1"},
	{name=>"UC_ARM64_REG_W7", macro=>"1"},
	{name=>"UC_ARM64_REG_W8", macro=>"1"},
	{name=>"UC_ARM64_REG_W9", macro=>"1"},
	{name=>"UC_ARM64_REG_W10", macro=>"1"},
	{name=>"UC_ARM64_REG_W11", macro=>"1"},
	{name=>"UC_ARM64_REG_W12", macro=>"1"},
	{name=>"UC_ARM64_REG_W13", macro=>"1"},
	{name=>"UC_ARM64_REG_W14", macro=>"1"},
	{name=>"UC_ARM64_REG_W15", macro=>"1"},
	{name=>"UC_ARM64_REG_W16", macro=>"1"},
	{name=>"UC_ARM64_REG_W17", macro=>"1"},
	{name=>"UC_ARM64_REG_W18", macro=>"1"},
	{name=>"UC_ARM64_REG_W19", macro=>"1"},
	{name=>"UC_ARM64_REG_W20", macro=>"1"},
	{name=>"UC_ARM64_REG_W21", macro=>"1"},
	{name=>"UC_ARM64_REG_W22", macro=>"1"},
	{name=>"UC_ARM64_REG_W23", macro=>"1"},
	{name=>"UC_ARM64_REG_W24", macro=>"1"},
	{name=>"UC_ARM64_REG_W25", macro=>"1"},
	{name=>"UC_ARM64_REG_W26", macro=>"1"},
	{name=>"UC_ARM64_REG_W27", macro=>"1"},
	{name=>"UC_ARM64_REG_W28", macro=>"1"},
	{name=>"UC_ARM64_REG_W29", macro=>"1"},
	{name=>"UC_ARM64_REG_W30", macro=>"1"},
	{name=>"UC_ARM64_REG_X0", macro=>"1"},
	{name=>"UC_ARM64_REG_X1", macro=>"1"},
	{name=>"UC_ARM64_REG_X2", macro=>"1"},
	{name=>"UC_ARM64_REG_X3", macro=>"1"},
	{name=>"UC_ARM64_REG_X4", macro=>"1"},
	{name=>"UC_ARM64_REG_X5", macro=>"1"},
	{name=>"UC_ARM64_REG_X6", macro=>"1"},
	{name=>"UC_ARM64_REG_X7", macro=>"1"},
	{name=>"UC_ARM64_REG_X8", macro=>"1"},
	{name=>"UC_ARM64_REG_X9", macro=>"1"},
	{name=>"UC_ARM64_REG_X10", macro=>"1"},
	{name=>"UC_ARM64_REG_X11", macro=>"1"},
	{name=>"UC_ARM64_REG_X12", macro=>"1"},
	{name=>"UC_ARM64_REG_X13", macro=>"1"},
	{name=>"UC_ARM64_REG_X14", macro=>"1"},
	{name=>"UC_ARM64_REG_X15", macro=>"1"},
	{name=>"UC_ARM64_REG_X16", macro=>"1"},
	{name=>"UC_ARM64_REG_X17", macro=>"1"},
	{name=>"UC_ARM64_REG_X18", macro=>"1"},
	{name=>"UC_ARM64_REG_X19", macro=>"1"},
	{name=>"UC_ARM64_REG_X20", macro=>"1"},
	{name=>"UC_ARM64_REG_X21", macro=>"1"},
	{name=>"UC_ARM64_REG_X22", macro=>"1"},
	{name=>"UC_ARM64_REG_X23", macro=>"1"},
	{name=>"UC_ARM64_REG_X24", macro=>"1"},
	{name=>"UC_ARM64_REG_X25", macro=>"1"},
	{name=>"UC_ARM64_REG_X26", macro=>"1"},
	{name=>"UC_ARM64_REG_X27", macro=>"1"},
	{name=>"UC_ARM64_REG_X28", macro=>"1"},

	{name=>"UC_ARM64_REG_V0", macro=>"1"},
	{name=>"UC_ARM64_REG_V1", macro=>"1"},
	{name=>"UC_ARM64_REG_V2", macro=>"1"},
	{name=>"UC_ARM64_REG_V3", macro=>"1"},
	{name=>"UC_ARM64_REG_V4", macro=>"1"},
	{name=>"UC_ARM64_REG_V5", macro=>"1"},
	{name=>"UC_ARM64_REG_V6", macro=>"1"},
	{name=>"UC_ARM64_REG_V7", macro=>"1"},
	{name=>"UC_ARM64_REG_V8", macro=>"1"},
	{name=>"UC_ARM64_REG_V9", macro=>"1"},
	{name=>"UC_ARM64_REG_V10", macro=>"1"},
	{name=>"UC_ARM64_REG_V11", macro=>"1"},
	{name=>"UC_ARM64_REG_V12", macro=>"1"},
	{name=>"UC_ARM64_REG_V13", macro=>"1"},
	{name=>"UC_ARM64_REG_V14", macro=>"1"},
	{name=>"UC_ARM64_REG_V15", macro=>"1"},
	{name=>"UC_ARM64_REG_V16", macro=>"1"},
	{name=>"UC_ARM64_REG_V17", macro=>"1"},
	{name=>"UC_ARM64_REG_V18", macro=>"1"},
	{name=>"UC_ARM64_REG_V19", macro=>"1"},
	{name=>"UC_ARM64_REG_V20", macro=>"1"},
	{name=>"UC_ARM64_REG_V21", macro=>"1"},
	{name=>"UC_ARM64_REG_V22", macro=>"1"},
	{name=>"UC_ARM64_REG_V23", macro=>"1"},
	{name=>"UC_ARM64_REG_V24", macro=>"1"},
	{name=>"UC_ARM64_REG_V25", macro=>"1"},
	{name=>"UC_ARM64_REG_V26", macro=>"1"},
	{name=>"UC_ARM64_REG_V27", macro=>"1"},
	{name=>"UC_ARM64_REG_V28", macro=>"1"},
	{name=>"UC_ARM64_REG_V29", macro=>"1"},
	{name=>"UC_ARM64_REG_V30", macro=>"1"},
	{name=>"UC_ARM64_REG_V31", macro=>"1"},
	{name=>"UC_ARM64_REG_PC", macro=>"1"},
	{name=>"UC_ARM64_REG_IP1", macro=>"1"},
	{name=>"UC_ARM64_REG_IP0", macro=>"1"},
	{name=>"UC_ARM64_REG_FP", macro=>"1"},
	{name=>"UC_ARM64_REG_LR", macro=>"1"},
          );
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'UnicornEngine',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
