*****           Implementation of object type ZHR_DPO              *****
INCLUDE <OBJECT>.
BEGIN_DATA OBJECT. " Do not change.. DATA is generated
* only private members may be inserted into structure private
DATA:
" begin of private,
"   to declare private attributes remove comments and
"   insert private attributes here ...
" end of private,
  BEGIN OF KEY,
      DPOREQUEST LIKE ZHR_DPO_ZAD-DPO_REQUEST,
  END OF KEY.
END_DATA OBJECT. " Do not change.. DATA is generated
