* ƒополнительные бонусы по срокам подписки - возвращает кол-во дней (?) подписки
function bdate

    lparameters tck
    
    local lckey, lnadddays
    
    if type('tcK') = 'C' .and. .not. empty(tck)
        lckey = tck
    else
        lckey = goapp.ckey
    endif
    
    if between(substr(lckey, 14, 1), 'a', 'z') .and. (between(substr(lckey, 015, 1), 'E', 'W') .or. between(substr(lckey, 015, 1), 'd', 'o')) .and. between(substr(lckey, 016, 1), 'c', 'n')
        lnyear = asc(substr(lckey, 14, 1)) - asc('a') + 2001
        if lnyear < 2010
            do case
                case between(substr(lckey, 015, 1), 'E', 'W')
                    lnday = asc(substr(lckey, 015, 1)) - asc('E') + 1
                case between(substr(lckey, 015, 1), 'd', 'o')
                    lnday = asc(substr(lckey, 015, 1)) - asc('d') + 1 + 19
            endcase
            lnmonth = asc(substr(lckey, 016, 1)) - asc('c') + 1
            lcgendate = date(lnyear, lnmonth, lnday)
            lnadddays = 0
            do case
                case lcgendate < date(2003, 12, 31)
                    lnadddays = 60
                otherwise
                    return 5
            endcase
            return lnadddays + 5
        else
            return 5
        endif
    else
        return 5
    endif

endfunc

function testg

    lparameters tcv
    
    * это должно быть FALSE
    this.parent.ldesc = substr(tcv, 18, 1) = 'R'
    
    return substr(tcv, 12, 1) $ 'KN'

endfunc

* проверка легальности
* TRUE - код верен
function testsorted

    lparameters p_name, p_code

    local tmp_str, flg1, flg2
    local l_code, l_name, bad_reg, l_str1, l_crc
    local l_year, l_day, l_mon, lconerror, llwaserror

    lconerror = on("ERROR")
    llwaserror = .f.

    on error LLWASERROR = .t.

    if empty(p_name) .or. empty(p_code)
        return .f.
    endif

    tmp_str = 'K'

    if cpcurrent(1) = 1251
        flg1 = .t.
        flg2 = .f.
    else
        if date() > date(2005, 10, 15)
            flg1 = .f.
            flg2 = .f.
        else
            flg1 = .t.
            flg2 = .t.
        endif
    endif

    bad_reg = .f.

    l_name = alltrim(p_name)
    l_code = alltrim(p_code)

    l_str1 = substr(l_code, 17, 1)

    if bittest(asc(l_str1), 0) .and. bittest(asc(l_str1), 6)
    else
        bad_reg = .t.
    endif

    l_crc = sys(2007, l_name + substr(l_code, 1, 1) + substr(l_code, 7, 5) + substr(l_code, 12, 1) + substr(l_code, 13, 1) + substr(l_code, 14, 3) + substr(l_code, 17, 1) + substr(l_code, 18, 1) + substr(l_code, 19, 1) + substr(l_code, 20, 1) + substr(l_code, 21, 3) + substr(l_code, 1, 1))
    l_crc = padl(alltrim(l_crc), 5, '0')
    
    bad_reg = .not. (between(val(substr(l_code, 20, 1)), 1, 9) .or. inlist(substr(l_code, 20, 1), 'y', 'r', 't'))
    
    l_crc = chrtran(l_crc, '05829', 'GeSuy')

    if substr(l_code, 2, 5) == l_crc .and. (flg1 .or. flg2)

        l_str1 = substr(l_code, 13, 1)

        do case
            case l_str1 $ 'g4'
                goapp.help.nlt = 1	&& Lite
            case l_str1 $ 'DwU'
                goapp.help.nlt = 2	&& Standard
            case l_str1 $ '8r2'
                goapp.help.nlt = 3	&& Pro
            case l_str1 $ 'Imd'
                goapp.help.nlt = 4	&& Elite
            case l_str1 $ 'pP1'
                goapp.help.nlt = 1	&& Lite VIP
            case l_str1 $ '7AT'
                goapp.help.nlt = 2	&& Standard VIP
            case l_str1 $ 'Wnt'
                goapp.help.nlt = 3	&& Pro VIP
            case l_str1 $ 'JKG'
                goapp.help.nlt = 4	&& Elite VIP
        endcase

        if this.security.testg(l_code)

            l_year = asc(substr(l_code, 21, 1)) + 1904

            do case
                case between(substr(l_code, 022, 1), 'E', 'W')
                    l_day = asc(substr(l_code, 022, 1)) - 68
                case between(substr(l_code, 022, 1), 'd', 'o')
                    l_day = asc(substr(l_code, 022, 1)) - 80
            endcase

            l_mon = asc(substr(l_code, 023, 1)) - 98

            if file('DofAB.MEM')

                restore from DofAB.MEM additive

                * lddateofappbuild - текуща€ дата
                if type('ldDateOfAppBuild') = 'D' .and. .not. empty(lddateofappbuild)

                    if date(l_year, l_mon, l_day) + bdate(l_code) < lddateofappbuild
                        bad_reg = .t.
                    endif

                else
                    bad_reg = .t.
                endif

            else
                bad_reg = .t.
            endif

        else
            bad_reg = .t.
        endif
    else
        bad_reg = .t.
    endif

    on error &lcOnError

    return .not. bad_reg .and. .not. llwaserror
endfunc
