/***************** "built-in" functions ********************************************/

/*
 * Trim function, trims all leading and trailing spaces:
 * str.trim()
 */
String.prototype.trim = function(){return
(this.replace(/^[\s\xA0]+/, "").replace(/[\s\xA0]+$/, ""))}

/*
 * startsWith to check if a string starts with a particular character sequecnce:
 * str.startsWith(strstr)
 */
String.prototype.startsWith = function(str)
{return (this.match("^"+str)==str)}

/*
 * endsWith to check if a string ends with a particular character sequecnce:
 * str.endsWith(strstr)
 */
String.prototype.endsWith = function(str)
{return (this.match(str+"$")==str)}
function number_format (number, decimals, dec_point, thousands_sep) {
    // http://kevin.vanzonneveld.net
    // +   original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +     bugfix by: Michael White (http://getsprink.com)
    // +     bugfix by: Benjamin Lupton
    // +     bugfix by: Allan Jensen (http://www.winternet.no)
    // +    revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +     bugfix by: Howard Yeend
    // +    revised by: Luke Smith (http://lucassmith.name)
    // +     bugfix by: Diogo Resende
    // +     bugfix by: Rival
    // +      input by: Kheang Hok Chin (http://www.distantia.ca/)
    // +   improved by: davook
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +      input by: Jay Klehr
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +      input by: Amir Habibi (http://www.residence-mixte.com/)
    // +     bugfix by: Brett Zamir (http://brett-zamir.me)
    // +   improved by: Theriault
    // +      input by: Amirouche
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // *     example 1: number_format(1234.56);
    // *     returns 1: '1,235'
    // *     example 2: number_format(1234.56, 2, ',', ' ');
    // *     returns 2: '1 234,56'
    // *     example 3: number_format(1234.5678, 2, '.', '');
    // *     returns 3: '1234.57'
    // *     example 4: number_format(67, 2, ',', '.');
    // *     returns 4: '67,00'
    // *     example 5: number_format(1000);
    // *     returns 5: '1,000'
    // *     example 6: number_format(67.311, 2);
    // *     returns 6: '67.31'
    // *     example 7: number_format(1000.55, 1);
    // *     returns 7: '1,000.6'
    // *     example 8: number_format(67000, 5, ',', '.');
    // *     returns 8: '67.000,00000'
    // *     example 9: number_format(0.9, 0);
    // *     returns 9: '1'
    // *    example 10: number_format('1.20', 2);
    // *    returns 10: '1.20'
    // *    example 11: number_format('1.20', 4);
    // *    returns 11: '1.2000'
    // *    example 12: number_format('1.2000', 3);
    // *    returns 12: '1.200'
    // *    example 13: number_format('1 000,50', 2, '.', ' ');
    // *    returns 13: '100 050.00'
    // Strip all characters but numerical ones.
    number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
    var n = !isFinite(+number) ? 0 : +number,
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        s = '',
        toFixedFix = function (n, prec) {
            var k = Math.pow(10, prec);
            return '' + Math.round(n * k) / k;
        };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}

/************** PHP function www.phpjs.org **************************************/
function strstr (haystack, needle, bool) {
    // Finds first occurrence of a string within another
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/strstr
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   bugfixed by: Onno Marsman
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // *     example 1: strstr('Kevin van Zonneveld', 'van');
    // *     returns 1: 'van Zonneveld'
    // *     example 2: strstr('Kevin van Zonneveld', 'van', true);
    // *     returns 2: 'Kevin '
    // *     example 3: strstr('name@example.com', '@');
    // *     returns 3: '@example.com'
    // *     example 4: strstr('name@example.com', '@', true);
    // *     returns 4: 'name'
    var pos = 0;

    haystack += '';
    pos = haystack.indexOf( needle );
    if (pos == -1) {
	return false;
    } else{
	if (bool){
	    return haystack.substr( 0, pos );
	} else{
	    return haystack.slice( pos );
	}
    }
}

function substr_count (haystack, needle, offset, length) {
    // Returns the number of times a substring occurs in the string
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/substr_count
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   bugfixed by: Onno Marsman
    // *     example 1: substr_count('Kevin van Zonneveld', 'e');
    // *     returns 1: 3
    // *     example 2: substr_count('Kevin van Zonneveld', 'K', 1);
    // *     returns 2: 0
    // *     example 3: substr_count('Kevin van Zonneveld', 'Z', 0, 10);
    // *     returns 3: false
    var pos = 0, cnt = 0;

    haystack += '';
    needle += '';
    if (isNaN(offset)) {
	offset = 0;
    }
    if (isNaN(length)) {
	length = 0;
    }
    offset--;

    while ((offset = haystack.indexOf(needle, offset+1)) != -1){
	if (length > 0 && (offset+needle.length) > length){
	    return false;
	} else{
	    cnt++;
	}
    }

    return cnt;
}

function strpos (haystack, needle, offset) {
    // Finds position of first occurrence of a string within another
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/strpos
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Onno Marsman
    // +   bugfixed by: Daniel Esteban
    // *     example 1: strpos('Kevin van Zonneveld', 'e', 5);
    // *     returns 1: 14
    var i = (haystack+'').indexOf(needle, (offset ? offset : 0));
    return i === -1 ? false : i;
}

function str_repeat ( input, multiplier ) {
    // Returns the input string repeat mult times
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/str_repeat
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // *     example 1: str_repeat('-=', 10);
    // *     returns 1: '-=-=-=-=-=-=-=-=-=-='


    return new Array(multiplier+1).join(input);
}

function ltrim ( str, charlist ) {
    // Strips whitespace from the beginning of a string
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/ltrim
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +      input by: Erkekjetter
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   bugfixed by: Onno Marsman
    // *     example 1: ltrim('    Kevin van Zonneveld    ');
    // *     returns 1: 'Kevin van Zonneveld    '
    charlist = !charlist ? ' \\s\u00A0' : (charlist+'').replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '$1');
    var re = new RegExp('^[' + charlist + ']+', 'g');
    return (str+'').replace(re, '');
}

function rtrim ( str, charlist ) {
    // Removes trailing whitespace
    //
    // version: 911.718
    // discuss at: http://phpjs.org/functions/rtrim
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +      input by: Erkekjetter
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   bugfixed by: Onno Marsman
    // +   input by: rem
    // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
    // *     example 1: rtrim('    Kevin van Zonneveld    ');
    // *     returns 1: '    Kevin van Zonneveld'
    charlist = !charlist ? ' \\s\u00A0' : (charlist+'').replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '\\$1');
    var re = new RegExp('[' + charlist + ']+$', 'g');
    return (str+'').replace(re, '');
}

function trim (str, charlist) {
    // Strips whitespace from the beginning and end of a string
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/trim
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: mdsjack (http://www.mdsjack.bo.it)
    // +   improved by: Alexander Ermolaev (http://snippets.dzone.com/user/AlexanderErmolaev)
    // +      input by: Erkekjetter
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +      input by: DxGx
    // +   improved by: Steven Levithan (http://blog.stevenlevithan.com)
    // +    tweaked by: Jack
    // +   bugfixed by: Onno Marsman
    // *     example 1: trim('    Kevin van Zonneveld    ');
    // *     returns 1: 'Kevin van Zonneveld'
    // *     example 2: trim('Hello World', 'Hdle');
    // *     returns 2: 'o Wor'
    // *     example 3: trim(16, 1);
    // *     returns 3: 6
    var whitespace, l = 0, i = 0;
    str += '';

    if (!charlist) {
	// default list
	whitespace = " \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000";
    } else {
	// preg_quote custom list
	charlist += '';
	whitespace = charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '$1');
    }

    l = str.length;
    for (i = 0; i < l; i++) {
	if (whitespace.indexOf(str.charAt(i)) === -1) {
	    str = str.substring(i);
	    break;
	}
    }

    l = str.length;
    for (i = l - 1; i >= 0; i--) {
	if (whitespace.indexOf(str.charAt(i)) === -1) {
	    str = str.substring(0, i + 1);
	    break;
	}
    }

    return whitespace.indexOf(str.charAt(0)) === -1 ? str : '';
}

function substr (str, start, len) {
    // Returns part of a string
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/substr    // +     original by: Martijn Wieringa
    // +     bugfixed by: T.Wild
    // +      tweaked by: Onno Marsman
    // +      revised by: Theriault
    // *       example 1: substr('abcdef', 0, -1);    // *       returns 1: 'abcde'
    // *       example 2: substr(2, 0, -6);
    // *       returns 2: false
    // Add: (?) Use unicode.semantics and/or unicode.runtime_encoding (e.g., with string wrapped in "binary" or "Binary" class) to
    // allow access of binary (see file_get_contents()) by: charCodeAt(x) & 0xFF (see https://developer.mozilla.org/En/Using_XMLHttpRequest )// Fix: Handle 4-byte characters

    str += '';
    var end = str.length;
    if (start < 0) {
	start += end;
    }
    end = typeof len === 'undefined' ? end : (len < 0 ? len + end : len + start);
    // PHP returns false if start does not fall within the string.
    // PHP returns false if the calculated end comes before the calculated start.    // PHP returns an empty string if start and end are the same.
    // Otherwise, PHP returns the portion of the string from start to end.
    return start >= str.length || start < 0 || start > end ? !1 : str.slice(start, end);
}

function addslashes (str) {
    // Escapes single quote, double quotes and backslash characters in a string with backslashes
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/addslashes    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Ates Goral (http://magnetiq.com)
    // +   improved by: marrtins
    // +   improved by: Nate
    // +   improved by: Onno Marsman    // +   input by: Denny Wardhana
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // *     example 1: addslashes("kevin's birthday");
    // *     returns 1: 'kevin\'s birthday'
    return (str+'').replace(/([\\"'])/g, "\\$1").replace(/\u0000/g, "\\0");
}

function str_replace (search, replace, subject, count) {
    // Replaces all occurrences of search in haystack with replace
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/str_replace    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Gabriel Paderni
    // +   improved by: Philip Peterson
    // +   improved by: Simon Willison (http://simonwillison.net)
    // +    revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)    // +   bugfixed by: Anton Ongson
    // +      input by: Onno Marsman
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +    tweaked by: Onno Marsman
    // +      input by: Brett Zamir (http://brett-zamir.me)    // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   input by: Oleg Eremeev
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +   bugfixed by: Oleg Eremeev
    // %          note 1: The count parameter must be passed as a string in order    // %          note 1:  to find a global variable in which the result will be given
    // *     example 1: str_replace(' ', '.', 'Kevin van Zonneveld');
    // *     returns 1: 'Kevin.van.Zonneveld'
    // *     example 2: str_replace(['{name}', 'l'], ['hello', 'm'], '{name}, lars');
    // *     returns 2: 'hemmo, mars'    var i = 0, j = 0, temp = '', repl = '', sl = 0, fl = 0,
    f = [].concat(search),
    r = [].concat(replace),
    s = subject,
    ra = r instanceof Array, sa = s instanceof Array;
    s = [].concat(s);
    if (count) {
	this.window[count] = 0;
    }
    for (i=0, sl=s.length; i < sl; i++) {
	if (s[i] === '') {
	    continue;
	}
	for (j=0, fl=f.length; j < fl; j++) {
	    temp = s[i]+'';
	    repl = ra ? (r[j] !== undefined ? r[j] : '') : r[0];
	    s[i] = (temp).split(f[j]).join(repl);
	    if (count && s[i] !== temp) {
		this.window[count] += (temp.length-s[i].length)/f[j].length;
	    }
	}
    }
    return sa ? s : s[0];
}

function ucfirst (str) {
    // Makes a string's first character uppercase
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/ucfirst    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   bugfixed by: Onno Marsman
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // *     example 1: ucfirst('kevin van zonneveld');
    // *     returns 1: 'Kevin van zonneveld'    str += '';
    var f = str.charAt(0).toUpperCase();
    return f + str.substr(1);
}

function ucwords(str) {
    // Uppercase the first character of every word in a string
    //
    // version: 1001.2911
    // discuss at: http://phpjs.org/functions/ucwords    // +   original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +   improved by: Waldo Malqui Silva
    // +   bugfixed by: Onno Marsman
    // +   improved by: Robin
    // *     example 1: ucwords('kevin van zonneveld');    // *     returns 1: 'Kevin Van Zonneveld'
    // *     example 2: ucwords('HELLO WORLD');
    // *     returns 2: 'HELLO WORLD'
    return (str + '').replace(/^(.)|\s(.)/g, function ($1) {
	return $1.toUpperCase();
    });
}

function strtolower (str) {
    // Makes a string lowercase
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/strtolower    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Onno Marsman
    // *     example 1: strtolower('Kevin van Zonneveld');
    // *     returns 1: 'kevin van zonneveld'
    return (str+'').toLowerCase();
}

function strtoupper (str) {
    // Makes a string uppercase
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/strtoupper    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Onno Marsman
    // *     example 1: strtoupper('Kevin van Zonneveld');
    // *     returns 1: 'KEVIN VAN ZONNEVELD'
    return (str+'').toUpperCase();
}