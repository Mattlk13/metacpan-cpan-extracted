# DESCRIPTION

This module tries to implement [OWASP](https://owasp.org) password
recommendations for safe storage in Perl. In short OWASP recommends the
following:

- Don't limit password length or characters
- Hash the password before you crypt them
- Use either Argon2, PBKDF2, Scrypt or Bcrypt

This module currently supports Argon2, Scrypt and Bcrypt. All implementations
hash the password first with SHA-512. SHA-256 and SHA-1 are also supported.
This allows for storing password which are longer that 72 characters.

The check\_password method allows for weaker schemes as the module also allows
for inplace updates on these passwords. Please note that clear text passwords
need to be prepended with `{CLEARTEXT}` in order for [Authen::Passphrase](https://metacpan.org/pod/Authen::Passphrase) to
do its work.

# SYNOPSIS

    package MyApp::Authentication;

    use Password::OWASP::Scrypt; # or Bcrypt or Argon2

    my $user = get_from_db();

    my $owasp = Password::OWASP::Scrypt->new(

        # optional
        hashing => 'sha512',

        # Optional
        update_method => sub {
            my ($password) = @_;
            $user->update_password($password);
            return;
        },
    );

# SEE ALSO

- [Password::OWASP::Argon2](https://metacpan.org/pod/Password::OWASP::Argon2)
- [Password::OWASP::Scrypt](https://metacpan.org/pod/Password::OWASP::Scrypt)
- [Password::OWASP::Bcrypt](https://metacpan.org/pod/Password::OWASP::Bcrypt)
- [OWASP cheatsheet for password storage](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Password_Storage_Cheat_Sheet.md)
- [OWASP cheatsheet for authentication storage](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Authentication_Cheat_Sheet.md)
- [Authen::Passphrase](https://metacpan.org/pod/Authen::Passphrase)
- [Authen::Passphrase::Argon2](https://metacpan.org/pod/Authen::Passphrase::Argon2)
- [Authen::Passphrase::Scrypt](https://metacpan.org/pod/Authen::Passphrase::Scrypt)
- [Authen::Passphrase::BlowfishCrypt](https://metacpan.org/pod/Authen::Passphrase::BlowfishCrypt)
