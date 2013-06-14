#!perl
use strict;
use jQuery;

my $html = do { local $/; <DATA> };

jQuery->new($html);
jQuery("#single")->val("Single2");
jQuery("#multiple")->val(["Multiple2", "Multiple3"]); 
jQuery("input")->val(["check1","check2", "radio1" ]);

print jQuery->as_HTML;

__DATA__
<!DOCTYPE html>
<html>
<head>
  <style>
  body { color:blue; }
  </style>
  
</head>
<body>
  <select id="single">
    <option>Single</option>
    <option>Single2</option>
    <option>Single3</option>
  </select>

  <select id="multiple" multiple="multiple">
    <option selected="selected">Multiple</option>
    <option>Multiple2</option>
    <option selected="selected">Multiple3</option>
  </select><br/>
  <input type="checkbox" name="checkboxname" value="check1"/> check1
  <input type="checkbox" name="checkboxname" value="check2"/> check2
  <input type="radio"  name="r" value="radio1"/> radio1
  <input type="radio"  name="r" value="radio2"/> radio2
  
  
  <input id="test" type="test" value="sssss" />
  
<script>
    
    

</script>

</body>
</html>
