#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in DnDBeyond.com
# @raycast.mode silent
# @raycast.author Chris Koerner Zeller
# @raycast.authorURL https://github.com/ChessMess

# Optional parameters:
# @raycast.icon ./images/ddbicon.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "Searching for", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Category", "optional": true}
# @raycast.argument3 { "type": "text", "placeholder": "Subcategory", "optional": true}

case ${2} in
  'c'|'ch'|'cha'|'char'|'character'|'characters')
     c='characters'
     f='spells,backgrounds,classes,feats,races'
     ;;
  'cl'|'class'|'classes')
     c='characters'
     f='classes'
     ;;
  'com'|'compendium')
     c='compendium'
     f='actions,compendium,conditions,skills,rules,weapon-property'
     ;;
   'e'|'eq'|'equip'|'equipment')
     c='equipment'
     f='equipment,magic-items'
     ;;
   'f'|'fe'|'ft'|'feat'|'feats')
      c='characters'
      f='feats'
      ;;
   'i'|'it'|'ite'|'itm'|'item'|'items')
      c='items'
      f='equipment,magic-items'
      ;;
    'm'|'mag'|'magic'|'magical')
      c='items'
      f='spells,magic-items'
      ;;
    'mi'|'magicitems'|'magic items'|'magic-items')
      c='items'
      f='magic-items'
      ;;
    'r'|'ra'|'rac'|'race'|'races')
        c='characters'
        f='races'
        ;;
    'r'|'rule'|'rules')
        c='rules'
        f='rules'
        ;;
    's'|'sp'|'spell'|'spells')
      c='spells'
      f='spells'
      ;;
    'sk'|'skill'|'skills')
        c='skills'
        f='skills'
        ;;
    'v'|'vehicle')
        c='vehicle'
        f='vehicle'
        ;;
    'w'|'weap'|'weapon')
      c='equipment'
      f='equipment,magic-items'
      ;;

   *)
      c=${2}
      f=${3}
     ;;
esac

open "https://dndbeyond.com/search?q=${1}&c=${c}&f=${f}"
