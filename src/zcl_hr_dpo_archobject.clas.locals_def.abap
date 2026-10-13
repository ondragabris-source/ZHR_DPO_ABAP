*"* use this source file for any type declarations (class
*"* definitions, interfaces or data types) you need for method
*"* implementation or private method's signature


TYPES: BEGIN OF ts_dir,
         sap_object TYPE saeanwdid,
         handler    TYPE REF TO ZCL_HR_DPO_ARCHOBJECT,
       END OF ts_dir,

       tt_dir TYPE HASHED TABLE OF ts_dir WITH UNIQUE KEY SAP_OBJECT.
