use v5;

package Perlito5::Java::CORE;
use strict;


my %FileFunc = (
    # open FILEHANDLE,EXPR
    # open FILEHANDLE,MODE,EXPR
    # open FILEHANDLE,MODE,EXPR,LIST
    # open FILEHANDLE,MODE,REFERENCE
    # open FILEHANDLE
    open => <<'EOT',
        int argCount = List__.to_int();
        Path path = null; 
        String mode = "";
        try {
            fh.readlineBuffer = new StringBuilder();
            fh.eof = false;
            if (fh.outputStream != null) {
                fh.outputStream.close();
            }
            if (fh.reader != null) {
                fh.reader.close();
            }
            if (argCount == 0) {
                PlCORE.die("TODO - not implemented: single argument open()");
            }
            if (argCount == 1) {
                // EXPR
                String s = List__.aget(0).toString();
                path = Paths.get(s);
                PlCORE.die("TODO - not implemented: 2-argument open()");
            }
            if (argCount > 1) {
                // MODE,EXPR,LIST?
                mode = List__.aget(0).toString();
                String s = List__.aget(1).toString();
                path = Paths.get(s);
            }
            if (mode.equals("<")) {
                // TODO: charset
                fh.reader = Files.newBufferedReader(path);
                fh.outputStream = null;
            }
            else if (mode.equals(">")) {
                // TODO: charset
                fh.reader = null;
                fh.outputStream = new PrintStream(Files.newOutputStream(path, StandardOpenOption.CREATE));
            }
            else if (mode.equals(">>")) {
                // TODO: charset
                fh.reader = null;
                fh.outputStream = new PrintStream(Files.newOutputStream(path, StandardOpenOption.CREATE, StandardOpenOption.APPEND));
            }
            else {
                PlCORE.die("TODO - not implemented: open() mode '" + mode + "'");
            }
        }
        catch(IOException e) {
            PlV.set("main::v_!", new PlString(e.getMessage()));
            return PlCx.UNDEF;
        }
        return PlCx.INT1;
EOT
    close => <<'EOT',
        try {
            fh.readlineBuffer = new StringBuilder();
            fh.eof = true;
            if (fh.outputStream != null) {
                fh.outputStream.close();
            }
            if (fh.reader != null) {
                fh.reader.close();
            }
        }
        catch(IOException e) {
            PlV.set("main::v_!", new PlString(e.getMessage()));
            return PlCx.UNDEF;
        }
        return PlCx.INT1;
EOT
    print => <<'EOT',
        for (int i = 0; i < List__.to_int(); i++) {
            fh.outputStream.print(List__.aget(i).toString());
        }
        return PlCx.INT1;
EOT
    say => <<'EOT',
        for (int i = 0; i < List__.to_int(); i++) {
            fh.outputStream.print(List__.aget(i).toString());
        }
        fh.outputStream.println("");
        return PlCx.INT1;
EOT
    readline => <<'EOT',
        if (want == PlCx.LIST) {
            // read all lines
            PlArray res = new PlArray();
            PlObject s;
            while (!(s = PlCORE.readline(PlCx.SCALAR, fh, List__)).is_undef()) {
                res.push(s);
            }
            return res;
        }
        PlObject plsep = PlV.get("main::v_/");
        boolean slurp = false;
        if (plsep.is_undef()) {
            slurp = true;
        }
        if (fh.eof) {
            if (fh.is_argv) {
                // "ARGV" is special
                PlArray argv = PlV.array_get("main::List_ARGV");
                PlFileHandle in = new PlFileHandle();
                if (argv.to_int() > 0) {
                    // arg list contains file name
                    PlCORE.open(PlCx.VOID, in, new PlArray(new PlString("<"), argv.shift()));
                }
                else {
                    // read from STDIN
                    in  = PlCx.STDIN;
                }
                fh.readlineBuffer   = in.readlineBuffer;
                fh.eof              = in.eof;
                fh.outputStream     = in.outputStream;
                fh.reader           = in.reader;
            }
            if (fh.eof) {
                return PlCx.UNDEF;
            }
        }
        String sep = plsep.toString();
        StringBuilder buf = fh.readlineBuffer;
        // read from filehandle until "sep" or eof()
        int pos = slurp ? -1 : buf.indexOf(sep);
        while (pos < 0 && !fh.eof) {
            // read more
            int len = 1000;
            char[] c = new char[len];
            int num_chars = 0;
            try {
                num_chars = fh.reader.read(c, 0, len);
                if (num_chars > 0) {
                    // TODO - use: new String(bytes,"UTF-8")
                    String s = new String(c, 0, num_chars);
                    buf.append(s);
                }
            }
            catch(IOException e) {
                PlV.set("main::v_!", new PlString(e.getMessage()));
                return PlCx.UNDEF;
            }
            if (num_chars > 0) {
                if (!slurp) {
                    pos = buf.indexOf(sep);
                }
            }
            else {
                // eof
                fh.eof = true;
            }
        }
        String s;
        if (fh.eof || pos < 0) {
            s = buf.toString();
            fh.readlineBuffer = new StringBuilder();
            fh.eof = true;
            if (s.length() == 0) {
                return PlCx.UNDEF;
            }
        }
        else {
            pos += sep.length();
            s = buf.substring(0, pos);
            fh.readlineBuffer = new StringBuilder(buf.substring(pos));
        }
        return new PlString(s);
EOT
    # getc FILEHANDLE
    getc => <<'EOT',
        PlLvalue buf = new PlLvalue();
        PlCORE.sysread(want, fh, PlArray.construct_list_of_aliases(buf, PlCx.INT1));
        return buf;
EOT
    # read FILEHANDLE,SCALAR,LENGTH,OFFSET?
    read => <<'EOT',
        return PlCORE.sysread(want, fh, List__);
EOT
    # sysread FILEHANDLE,SCALAR,LENGTH,OFFSET?
    #   result is stored in $_[0]
    #   result may be utf8 or not
    #   returns number of bytes read
    #   set $! on error
    sysread => <<'EOT',
        int leng = List__.aget(1).to_int();
        int ofs = List__.aget(2).to_int();

        if (fh.eof) {
            return PlCx.UNDEF;
        }
        StringBuilder buf = fh.readlineBuffer;
        // read from filehandle until "len"
        int pos = buf.length();
        while (pos < leng && !fh.eof) {
            // read more
            int len = 1000;
            char[] c = new char[len];
            int num_chars = 0;
            try {
                num_chars = fh.reader.read(c, 0, len);
                if (num_chars > 0) {
                    // TODO - use: new String(bytes,"UTF-8")
                    String s = new String(c, 0, num_chars);
                    buf.append(s);
                }
            }
            catch(IOException e) {
                PlV.set("main::v_!", new PlString(e.getMessage()));
                return PlCx.UNDEF;
            }
            if (num_chars > 0) {
                pos = buf.length();
            }
            else {
                // eof
                fh.eof = true;
            }
        }
        String s;
        if (fh.eof || pos < leng) {
            s = buf.toString();
            fh.readlineBuffer = new StringBuilder();
            fh.eof = true;
            if (s.length() == 0) {
                return PlCx.UNDEF;
            }
        }
        else {
            s = buf.substring(0, leng);
            fh.readlineBuffer = new StringBuilder(buf.substring(leng));
        }

        leng = s.length();
        if (ofs == 0) {
            List__.aset(0, s);
        }
        else {
            die("TODO: sysread with OFFSET");
        }
        return new PlInt(leng);
EOT
);


sub emit_java {
    return <<'EOT'

class PlCORE {
EOT
    # emit all file-related functions
    . join("", map {
          "    public static final PlObject $_(int want, PlObject filehandle, PlArray List__) {\n"
        . "        PlFileHandle fh = PerlOp.get_filehandle(filehandle);\n"
        .       $FileFunc{$_}
        . "    }\n"
        . "    public static final PlObject $_(int want, String filehandle, PlArray List__) {\n"
        . "        PlFileHandle fh = PerlOp.get_filehandle(filehandle);\n"
        .       $FileFunc{$_}
        . "    }\n"
        } sort keys %FileFunc
    ) . <<'EOT'
    public static final PlObject say(String s) {
        // say() shortcut for internal use
        return PlCORE.say(PlCx.VOID, PlCx.STDOUT, new PlArray(new PlString(s)));
    }
    public static final PlObject exit(int want, PlArray List__) {
        int arg = List__.aget(0).to_int();
        System.exit(arg);
        return PlCx.UNDEF;
    }
    public static final PlObject warn(int want, PlArray List__) {
        for (int i = 0; i < List__.to_int(); i++) {
            PlCx.STDERR.outputStream.print(List__.aget(i).toString());
        }
        PlCx.STDERR.outputStream.println("");
        return PlCx.INT1;
    }
    public static final PlObject die(int want, PlArray List__) {
        PlObject arg = List__.aget(0);
        if (arg.is_undef() || (arg.is_string() && arg.toString() == "")) {
            throw new PlDieException(PlCx.DIED);
        }
        if (List__.to_int() == 1) {
            throw new PlDieException(arg);
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < List__.to_int(); i++) {
            String item = List__.aget(i).toString();
            sb.append(item);
        }
        throw new PlDieException(new PlString(sb.toString()));
    }
    public static final PlObject die(String s) {
        // die() shortcut
        return PlCORE.die(PlCx.VOID, new PlArray(new PlString(s)));
    }
    public static final PlString ref(int want, PlArray List__) {
        return List__.aget(0).ref();
    }
    public static final PlObject values(int want, PlObject List__) {
        return want == PlCx.LIST ? List__.values() : List__.values().scalar();
    }
    public static final PlObject keys(int want, PlObject List__) {
        return want == PlCx.LIST ? List__.keys() : List__.keys().scalar();
    }
    public static final PlObject each(int want, PlObject List__) {
        return want == PlCx.LIST ? List__.each() : List__.each().aget(0);
    }
    public static final PlObject chomp(int want, PlObject Object__) {
        String sep = PlV.get("main::v_/").toString();
        int sepSize = sep.length();
        int result = 0;
        String toChomp = Object__.toString();
        if(toChomp.substring(toChomp.length() - sepSize, toChomp.length()).equals(sep)) {
            toChomp = toChomp.substring(0, toChomp.length() - sepSize);
            result += sepSize;
        }

        Object__.set(new PlString(toChomp));
            
        return new PlInt(result);
    }
    public static final PlObject chomp(int want, PlArray List__) {
        int result = 0;
        for(int i = 0; i < List__.to_int(); ++i) {
            PlObject item = List__.aget_lvalue(i);
            result += chomp(want, item).to_int();
        }

        return new PlInt(result);
    }
    public static final PlString chop(int want, PlObject Object__) {
        String str = Object__.toString();
        String returnValue = "";
        if (str.length() > 0) {
            returnValue = str.substring(str.length() -1);
            Object__.set(new PlString(str.substring(0, str.length()-1)));
        }

        return new PlString(returnValue);
    }
    public static final PlObject chop(int want, PlArray List__) {
        PlString result = PlCx.EMPTY;
        for(int i = 0; i < List__.to_int(); ++i) {
            PlObject item = List__.aget_lvalue(i);
            result = chop(want, item);
        }

        return result;
    }
    public static final PlObject scalar(int want, PlArray List__) {
        if (List__.to_int() == 0) {
            return PlCx.UNDEF;
        }
        return List__.aget(-1).scalar();
    }
    public static final PlObject hex(int want, PlObject List__) {
        String s = List__.toString();
        if(s.startsWith("0x") || s.startsWith("0X")) {
            s = s.substring(2);
        }
        try {
            return new PlInt(Long.parseLong(s, 16));
        } catch (java.lang.NumberFormatException e) {
            return new PlInt(0);
        }
    }
    public static final PlObject oct(int want, PlObject List__) {
	    String valueTobeCoverted = List__.toString();
	    try {
	    	if (valueTobeCoverted.startsWith("0x") || valueTobeCoverted.startsWith("0X")) {
	    		return new PlInt(Long.parseLong(valueTobeCoverted.substring(2), 16));
	    	} else if (valueTobeCoverted.startsWith("0b") || valueTobeCoverted.startsWith("0B")) {
	    		return new PlInt(Long.parseLong(valueTobeCoverted.substring(2), 2));
	    	} else {
	    		return new PlInt(Long.parseLong(valueTobeCoverted, 8));
	    	}
	    } catch (NumberFormatException n) {
	    	
	    } catch (Exception e) {
	    	// result = e.getMessage();
	    }
	    return new PlInt(0);
    }
    public static final PlObject sprintf(int want, PlObject List__) {
        String format = List__.aget(0).toString();
        // "%3s"
        int length = format.length();
        int offset = 0;
        int args_max = List__.to_int();
        int args_index = 0;
        Object args[] = new Object[args_max];
        for ( ; offset < length; ) {
            int c = format.codePointAt(offset);
            switch (c) {
                case '%':
                    offset++;
                    boolean scanning = true;
                    for ( ; offset < length && scanning ; ) {
                        c = format.codePointAt(offset);
                        switch (c) {
                            case '%':
                                scanning = false;
                                offset++;
                                break;
                            case 'c': case 's': case 'd': case 'u': case 'o':
                            case 'x': case 'e': case 'f': case 'g':
                            case 'X': case 'E': case 'G': case 'b':
                            case 'B': case 'p': case 'n':
                            case 'i': case 'D': case 'U': case 'O': case 'F':
                                scanning = false;
                                switch (c) {
                                    case 's':
                                        args[args_index] = List__.aget(args_index+1).toString();
                                        break;
                                    case 'd': case 'o': case 'x': case 'X':
                                    case 'u': case 'b': case 'B': case 'p':
                                    case 'c':
                                        args[args_index] = List__.aget(args_index+1).to_int();
                                        break;
                                    case 'f': case 'e': case 'g':
                                    case 'E': case 'G':
                                        args[args_index] = List__.aget(args_index+1).to_double();
                                        break;
                                    default:
                                        break;
                                }
                                args_index++;
                                if (args_index > args_max) {
                                    // panic
                                    offset = length;
                                }
                                offset++;
                                break;
                            default:
                                offset++;
                                break;
                        }
                    }
                    break;
                default:
                    offset++;
                    break;
            }
        }
        return new PlString(String.format(format, args));
    }
    public static final PlObject crypt(int want, PlArray List__) {
        if(List__.to_int() < 2) {
            die("Not enough arguments for crypt");
        }
        if(List__.to_int() > 2) {
            die("Too many arguments for crypt");
        }
        String plainText = List__.shift().toString();
        String salt = List__.shift().toString();

        while(salt.length() < 2) {
            salt = salt.concat(".");
        }
        
        return new PlString(PlCrypt.crypt(salt, plainText));
    }
    public static final PlObject join(int want, PlArray List__) {
        String s = List__.shift().toString();
        StringBuilder sb = new StringBuilder();
        boolean first = true;
        for (int i = 0; i < List__.to_int(); i++) {
            String item = List__.aget(i).toString();
            if (first)
                first = false;
            else
                sb.append(s);
            sb.append(item);
        }
        return new PlString(sb.toString());
    }
    public static final PlObject reverse(int want, PlArray List__) {
        if (want == PlCx.LIST) {
            PlArray ret = new PlArray(List__);
            Collections.reverse(ret.a);
            return ret;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < List__.to_int(); i++) {
            sb.append( List__.aget(i).toString() );
        }
        return new PlString(sb.reverse().toString());
    }
    public static final PlObject fc(int want,  PlObject Object__) {
        return new PlString(Object__.toString().toLowerCase());
    }
    public static final PlObject pack(int want, PlArray List__) {
        String template = List__.aget(0).toString();
        StringBuilder result = new StringBuilder();
        int index = 1;
        for(int i = 0; i < template.length(); ++i) {
            switch(template.charAt(i)) {
            case 'a':
            {
                int size = pack_size(template, i);
                result.append(pack_a(List__.aget(index).toString(), size));
                ++index;
                break;
            }
            case 'A':
            {    
                int size = pack_size(template, i);
                result.append(pack_A(List__.aget(index).toString(), size));
                ++index;
                break;
            }
            case 'Z':
            {
                int size = pack_size(template, i);
                result.append(pack_Z(List__.aget(index).toString(), size));
                ++index;
                break;
            }
            case 'b':
            {
                int size = pack_size(template, i);
                result.append(pack_b(List__.aget(index).toString(), size));
                ++index;
                break;
            }
            case 'B':
            {
                int size = pack_size(template, i);
                result.append(pack_B(List__.aget(index).toString(), size));
                ++index;
                break;
            }
            case 'h':
            {
                int size = pack_size(template, i);
                result.append(pack_h(List__.aget(index).toString(), size));
                ++index;
                break;
            }
            case 'H':
            {
                int size = pack_size(template, i);
                result.append(pack_H(List__.aget(index).toString(), size));
                ++index;
                break;        
            }
            case 'c':
            {
                result.append(pack_c(List__.aget(index).toString()));
                ++index;
                break;        
            }
            case 'C':
            {
                result.append(pack_C(List__.aget(index).toString()));
                ++index;
                break;        
            }
            case 'W':
            {
                result.append(pack_W(List__.aget(index).toString()));
                ++index;
                break;        
            }
            case 's':
            {
                result.append(pack_s(List__.aget(index).toString()));
                ++index;
                break;        
            }
            case 'L':
            {
                result.append(pack_L(List__.aget(index).toString()));
                ++index;
                break;        
            }
            case 'I':
            {
                result.append(pack_I(List__.aget(index).toString()));
                ++index;
                break;        
            }
            case 'f':
            {
                result.append(pack_f(List__.aget(index).to_double()));
                ++index;
                break;        
            }
            case 'd':
            case 'F':
            {
                result.append(pack_d(List__.aget(index).to_double()));
                ++index;
                break;        
            }
            case 'u':
            {
                result.append(pack_u(List__.aget(index).toString()));
                ++index;
                break;
            }
            default:
            }
        }

        return new PlString(result.toString());
    }
    private static final int pack_size(String s, int pos) {
        int howMany = 0;
        while(s.length() > (pos + 1 + howMany) && java.lang.Character.isDigit(s.charAt(pos + 1 + howMany))) {
            ++howMany;
        }
        if(howMany != 0) {
            return java.lang.Integer.parseInt(s.substring(pos + 1, pos + 1 + howMany));
        }
        return 1;
    }
    private static final String pack_a(String s, int size) {
        if(s.length() >= size) {
            return s.substring(0,size);
        }
        String padding = new String(new char[size - s.length()]);
        return s + padding;    
    }
    private static final String pack_A(String s, int size) {
        if(s.length() >= size) {
            return s.substring(0,size);
        }
        String padding = new String(new char[size - s.length()]).replace('\0', ' ');
        return s + padding;    
    }
    private static final String pack_Z(String s, int size) {
        s = s.substring(0, java.lang.Math.min(size - 1, s.length()));
        return s +  new String(new char[size - s.length()]);
    }
    private static final String pack_b(String s, int size) {
        s = s.substring(0, Math.min(size, s.length()));
        int wanted8strings = (size + 7) / 8;
        s += new String(new char[(wanted8strings * 8) - s.length()]).replace('\0', '0');
        StringBuilder input = new StringBuilder();
        for(int i = 0; i < s.length(); ++i) {
            if(s.codePointAt(i) % 2 == 1) {
                input.append("1");
            }
            else {
                input.append("0");
            }
        }
        StringBuilder result = new StringBuilder();
        s = input.toString();
        for(int i = 0; i < wanted8strings; ++i) {
            String part = s.substring(i * 8, i * 8 + 8);
            int first = java.lang.Integer.parseInt(new StringBuilder(part.substring(0,4)).reverse().toString(), 2);
            int second = java.lang.Integer.parseInt(new StringBuilder(part.substring(4,8)).reverse().toString(), 2);
            result.append(Character.toString((char)(first + second * 16)));
        }
        return result.toString();
    }
    private static final String pack_B(String s, int size) {
        s = s.substring(0, Math.min(size, s.length()));
        int wanted8strings = (size + 7) / 8;
        s += new String(new char[(wanted8strings * 8) - s.length()]).replace('\0', '0');
        StringBuilder input = new StringBuilder();
        for(int i = 0; i < s.length(); ++i) {
            if(s.codePointAt(i) % 2 == 1) {
                input.append("1");
            }
            else {
                input.append("0");
            }
        }
        StringBuilder result = new StringBuilder();
        s = input.toString();
        for(int i = 0; i < wanted8strings; ++i) {
            String part = s.substring(i * 8, i * 8 + 8);
            int ascii = java.lang.Integer.parseInt(part, 2);
            result.append(Character.toString((char)ascii));
        }
        return result.toString();
    }
    private static final String pack_h(String s, int size) {
        int index  = 0;
        if(s.length() < size * 2) {
            s += new String(new char[size * 2 - s.length()]).replace('\0', '0');
        }
        StringBuilder result = new StringBuilder();
        while(index < size) {
            String part = s.substring(index + 1, index + 2) + s.substring(index, index + 1);
            int ascii = java.lang.Integer.parseInt(part, 16);
            result.append(Character.toString((char)ascii));
            index += 2;
        }
        return result.toString();
    }
    private static final String pack_H(String s, int size) {
        int index  = 0;
        if(s.length() < size * 2) {
            s += new String(new char[size * 2 - s.length()]).replace('\0', '0');
        }
        StringBuilder result = new StringBuilder();
        while(index < size) {
            String part = s.substring(index, index + 2);
            int ascii = java.lang.Integer.parseInt(part, 16);
            result.append(Character.toString((char)ascii));
            index += 2;
        }
        return result.toString();
    }
    private static String pack_c(String s) {
        try {
            int ascii = java.lang.Integer.parseInt(s) % 128;
            return Character.toString((char)ascii);
        } catch(Exception e) {
            return "";
        }
    }
    private static String pack_C(String s) {
        try {
            int ascii = (java.lang.Integer.parseInt(s) + 256) % 256;
            return Character.toString((char)ascii);
        } catch(Exception e) {
            return "";
        }
    }
    private static String pack_W(String s) {
        for(int i = 0; i < s.length(); ++i) {
            if(!java.lang.Character.isDigit(s.charAt(i))) {
                s = s.substring(0, i);
                break;
            }
        }
        int value = java.lang.Integer.parseInt(s);
        StringBuilder sb = new StringBuilder();
        sb.appendCodePoint(value);
        return sb.toString();
    }
    private static String pack_s(String s) {
        for(int i = 0; i < s.length(); ++i) {
            if(!java.lang.Character.isDigit(s.charAt(i))) {
                s = s.substring(0, i);
                break;
            }
        }
        short value = java.lang.Short.parseShort(s);
        char high = (char)(value / 256);
        char low = (char)(value % 256);
        StringBuilder result = new StringBuilder();
        result.append(Character.toString(high));
        result.append(Character.toString(low));
        return result.toString();        
    }
    public static final String pack_L(String s) {
        for(int i = 0; i < s.length(); ++i) {
            if(!java.lang.Character.isDigit(s.charAt(i))) {
                s = s.substring(0, i);
                break;
            }
        }
        long value = java.lang.Long.parseLong(s);
        char one = (char)(value / (int)Math.pow(2, 24));
        char two = (char)((value / (int)Math.pow(2, 16)) % 256);
        char three = (char)((value / (int)Math.pow(2, 8)) % 256);
        char four = (char)(value % 256);
        StringBuilder result = new StringBuilder();
        result.append(Character.toString(one));
        result.append(Character.toString(two));
        result.append(Character.toString(three));
        result.append(Character.toString(four));
        return result.toString();        
    }
    public static final String pack_I(String s) {
        return pack_L(s);
    }
    public static final String pack_f(double d) {
        float f = (float)d;
        int intBits = java.lang.Float.floatToRawIntBits(f); 
        char one = (char)(intBits / (int)Math.pow(2, 24));
        char two = (char)((intBits / (int)Math.pow(2, 16)) % 256);
        char three = (char)((intBits / (int)Math.pow(2, 8)) % 256);
        char four = (char)(intBits % 256);
        StringBuilder result = new StringBuilder();
        result.append(Character.toString(four));
        result.append(Character.toString(three));
        result.append(Character.toString(two));
        result.append(Character.toString(one));
        return result.toString();        
    }
    public static final String pack_d(double d) {
        long intBits = java.lang.Double.doubleToRawLongBits(d);
        char one =  (char)(intBits / (long)Math.pow(2, 56));
        char two = (char)((intBits / (long)Math.pow(2, 48)) % 256);
        char three = (char)((intBits / (long)Math.pow(2, 40)) % 256);
        char four = (char)((intBits / (long)Math.pow(2, 32)) % 256);
        char five = (char)((intBits / (long)Math.pow(2, 24)) % 256);
        char six = (char)((intBits / (long)Math.pow(2, 16)) % 256);
        char seven = (char)((intBits / (long)Math.pow(2, 8)) % 256);
        char eight = (char)(intBits % 256);
        StringBuilder result = new StringBuilder();
        result.append(eight);
        result.append(seven);
        result.append(six);
        result.append(five);
        result.append(four);
        result.append(three);
        result.append(two);
        result.append(one);
        return result.toString();        
    }
    public static final String pack_u(String s) {
        int index = 0;
        StringBuilder result = new StringBuilder();
        StringBuilder line = new StringBuilder();
        int tooMany = 0;
        while(s.length() > index * 3) {
            String cur = s.substring(index * 3, Math.min(index * 3 + 3, s.length()));
            while(cur.length() < 3) {
                ++tooMany;
                cur += '\0';
            }
            byte[] bytes = cur.getBytes();
            char value1 = (char)((bytes[0] >> 2) + 32);
            char value2 = (char)(((bytes[0] & 3) << 4) + (bytes[1] >> 4) + 32);
            char value3 = (char)(((bytes[1] & 15) << 2) + (bytes[2] >> 6) + 32);
            char value4 = (char)((bytes[2] & 63) + 32);

            line.append(value1);
            line.append(value2);
            line.append(value3);
            line.append(value4);
            
            if(line.length() == 60 && index != 0) {
                line.insert(0, (char)(32 + (45 - tooMany)));
                line.append("\n");
                result.append(line.toString());
                line = new StringBuilder();
            }
            ++index;
        }
        if(line.length() > 0) {
            line.insert(0, (char)(32 + ((index * 3 - tooMany) % 45)));
            line.append("\n");
            result.append(line);
        }

        return result.toString();
    }
    public static final PlObject time(int want, PlArray List__) {
        return new PlInt( (long)Math.floor(System.currentTimeMillis() * 0.001 + 0.5));
    }
    public static final PlObject sleep(int want, PlArray List__) {
        long s = (new Double(List__.shift().to_double() * 1000)).longValue();
        try {
            TimeUnit.MILLISECONDS.sleep(s);
        } catch (InterruptedException e) {
            //Handle exception
        }
        return new PlDouble(s / 1000.0);
    }
    public static final PlObject system(int want, PlArray List__) {
        // TODO - see perldoc -f system
        try {
            String[] args = new String[List__.to_int()];
            int i = 0;
            for (PlObject s : List__.a) {
                args[i++] = s.toString();
            }
            String s = null;
            Process p = Runtime.getRuntime().exec(args);
            // BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
            // BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            // System.out.println("STDOUT\n");
            // while ((s = stdInput.readLine()) != null) {
            //     System.out.println("  " + s);
            // }
            // System.out.println("STDERR\n");
            // while ((s = stdError.readLine()) != null) {
            //     System.out.println("  " + s);
            // }
            return PlCx.INT0;
        }
        catch (IOException e) {
            // System.out.println("IOexception: ");
            // e.printStackTrace();
            return PlCx.MIN1;
        }
    }
    public static final PlObject qx(int want, PlArray List__) {
        // TODO - see perldoc -f qx
        try {
            String[] args = new String[List__.to_int()];
            int i = 0;
            for (PlObject s : List__.a) {
                args[i++] = s.toString();
            }
            PlArray res = new PlArray();
            String s = null;
            Process p = Runtime.getRuntime().exec(args);
            BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
            // System.out.println("STDOUT\n");
            while ((s = stdInput.readLine()) != null) {
                // System.out.println("  " + s);
                res.push(s + "\n");
            }
            // BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            // System.out.println("STDERR\n");
            // while ((s = stdError.readLine()) != null) {
            //     System.out.println("  " + s);
            // }
            if (want == PlCx.LIST) {
                return res;
            }
            res.unshift(PlCx.EMPTY);
            return join(want, res);
        }
        catch (IOException e) {
            // System.out.println("IOexception: ");
            // e.printStackTrace();
            return PlCx.UNDEF;
        }
    }
}

EOT

} # end of emit_java()

1;

__END__

=pod

=head1 NAME

Perlito5::Java::CORE

=head1 DESCRIPTION

Provides runtime routines for the Perlito-in-Java compiled code

=head1 AUTHORS

Flavio Soibelmann Glock

=head1 COPYRIGHT

Copyright 2015 by Flavio Soibelmann Glock.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
