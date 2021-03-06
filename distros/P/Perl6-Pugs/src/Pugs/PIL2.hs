{-# OPTIONS_GHC -fglasgow-exts -funbox-strict-fields -fallow-overlapping-instances -fno-warn-orphans -fno-warn-incomplete-patterns -fallow-undecidable-instances -cpp #-}

{-|
    Pugs Intermediate Language, version 2.

>   And the Tree that was withered shall be renewed,
>   And he shall plant it in the high places,
>   And the City shall be blessed.
>   Sing all ye people!

-}


module Pugs.PIL2 (
    PIL_Environment(..),
    PIL_Stmts(..), PIL_Stmt(..), PIL_Decl(..),
    PIL_Expr(..), PIL_Literal(..), PIL_LValue(..),
    TParam(..), TCxt(..), TEnv(..),
) where
import Pugs.AST hiding (Prim)
import Pugs.Internals hiding (get, put)
import Pugs.Types
import Emit.PIR

-- import DrIFT.XML
-- {-! global : Haskell2Xml !-}

{-! global : Perl5, JSON, YAML !-}

{-|
    The plan here is to first compile the environment (subroutines,
    statements, etc.) to an abstract syntax tree ('PIL' -- Pugs Intermediate
    Language) using the 'compile' function and 'Compile' class.

- Unify the Apply and Bind forms into method calls.
    Apply becomes .postcircumfix:<( )>
    Bind becomes .infix:<:=>

- Compile-time object initiation built with opaque object binders

- A PIL tree is merely an (unordered!) set of static declarations;
  the responsibility of calling the main function -- let's call it &{''}
  just for fun -- resides on the runtime.

- Anonymous closures -- should they be lambda-lifted and given ANON
  names? If yes this gives us flexibility over CSE (common shared expression)
  optimization, but this may be BDUF.  No λ lifting for now.

- Okay, time to try a simple definition.

   [SRC] say "Hello, World!"
   [PIL] SigList.new('&').infix:<:=>(
            Code.new(
                body => [|
                    ::?MY.postcircumfix<{ }>('&say')
                        .postcircumfix<( )>(Str.new('Hello World'))
                |]
                ... # other misc attributes
            )
        )

    -- Compile time analysis of &say is needed here.
    -- We want to allow possibility of MMD (note _open_ pkgs by default)
       so there needs to be a generic form.
    -- Static binding performed as another optimization pass.

    -- Predefined objects (_always_ bound to the same thing in compiler)
        ::?MY       -- current lexical scope
        ::?OUR      -- current package scope
        Symbol resolution (static vs dynamic lookup) is to be done at
        pass-1 for PIL2.  The '&say' below is _definitely_ dynamic.
        Or is it?  Why?  Because @\@Larry@ mandates 'multi &*say' instead
        of a more restricted form of ::* as a default lexical scope
        that closes over the toplevel program.  Maybe pursue a ruling
        toward the more static definition, otherwise all builtins become
        _slower_ to infer than userdefined code, which is Just Not Right.

    -- String construction -- handled like perl5 using string overloading

       Ask @\@Larry@ for ruling over constant creation and propagation rules.
       (probably: use a macro if you'd like to change)
       so, safe to assume a prim form in PIL level.

    -- We _really_ need a quasiquoting notation for macro generation;
       introduce moral equivalent of [|...|] in PIL form, probably just an
       "AST" node.  (in CLR they call it System.Reflection.Expression)
       -- problem with this is it's a closed set; if we are to extend AST
          on the compiler level --
          -- nah, we aren't bootstrapping yet. KISS.

    -- This is a very imperative view; the runtime would be carrying
       instructions of populating the ObjSpace (Smalltalk, Ruby-ish)
       rather than fitting an AST into a lexical evaluator environment
       (LISP, Scheme-ish)

    -- Need better annotator for inferrence to work, esp. now it's
       populated with redundant .postcircumfix calls.  OTOH, they
       can be assumed to be closed under separate-compilation regime,
       so we eventually regain the signature.  But it'd be much slower
       than the current PIL1.  Oy vey.

    -- OTOH, refactor into a Callable role and introduce .apply?
       This is integral's (sensible) suggestion, but we don't have a
       Role system working yet, so why bother.

-}

data PIL_Environment = PIL_Environment
    { pilGlob :: [PIL_Decl]
    , pilMain :: PIL_Stmts
    }
    deriving (Show, Eq, Ord, Typeable)

data PIL_Stmts = PNil
    | PStmts
        { pStmt  :: !PIL_Stmt
        , pStmts :: !PIL_Stmts
        }
    | PPad
        { pScope :: !Scope
        , pSyms  :: ![(VarName, PIL_Expr)]
        , pStmts :: !PIL_Stmts
        }
    deriving (Show, Eq, Ord, Typeable)

data PIL_Stmt = PNoop | PStmt { pExpr :: !PIL_Expr } | PPos
        { pPos  :: !Pos
        , pExp  :: !Exp
        , pNode :: !PIL_Stmt
        }
    deriving (Show, Eq, Ord, Typeable)

data PIL_Expr
    = PRawName { pRawName :: !VarName }
    | PExp { pLV  :: !PIL_LValue }
    | PLit { pLit :: !PIL_Literal }
    | PThunk { pThunk :: !PIL_Expr }
    | PCode
        { pType    :: !SubType
        , pParams  :: ![TParam]
        , pLValue  :: !Bool
        , pIsMulti :: !Bool
        , pBody    :: !PIL_Stmts
        }
    deriving (Show, Eq, Ord, Typeable)

data PIL_Decl = PSub
    { pSubName      :: !SubName
    , pSubType      :: !SubType
    , pSubParams    :: ![TParam]
    , pSubLValue    :: !Bool
    , pSubIsMulti   :: !Bool
    , pSubBody      :: !PIL_Stmts
    }
    deriving (Show, Eq, Ord, Typeable)

data PIL_Literal = PVal { pVal :: Val }
    deriving (Show, Eq, Ord, Typeable)

data PIL_LValue = PVar { pVarName :: !VarName }
    | PApp 
        { pCxt  :: !TCxt
        , pFun  :: !PIL_Expr
        , pInv  :: !(Maybe PIL_Expr)
        , pArgs :: ![PIL_Expr]
        }
    | PAssign
        { pLHS  :: ![PIL_LValue]
        , pRHS  :: !PIL_Expr
        }
    | PBind
        { pLHS  :: ![PIL_LValue]
        , pRHS  :: !PIL_Expr
        }
    deriving (Show, Eq, Ord, Typeable)

data TParam = MkTParam
    { tpParam   :: !Param
    , tpDefault :: !(Maybe (PIL_Expr))
    }
    deriving (Show, Eq, Ord, Typeable)

data TCxt
    = TCxtVoid | TCxtLValue !Type | TCxtItem !Type | TCxtSlurpy !Type
    | TTailCall !TCxt
    deriving (Show, Eq, Ord, Typeable)

data TEnv = MkTEnv
    { tLexDepth :: !Int                 -- ^ Lexical scope depth
    , tTokDepth :: !Int                 -- ^ Exp nesting depth
    , tCxt      :: !TCxt                -- ^ Current context
    , tReg      :: !(TVar (Int, String))-- ^ Register name supply
    , tLabel    :: !(TVar Int)          -- ^ Label name supply
    }
    deriving (Show, Eq, Ord, Typeable)

