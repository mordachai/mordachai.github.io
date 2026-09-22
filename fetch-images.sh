#!/usr/bin/env bash
# Downloads the README screenshots used by index.html into images/<repo>/
# so the site serves them itself instead of hotlinking github.com.
# Run it from this folder:  bash fetch-images.sh
# Re-run it whenever you add or change screenshots in the list below.

set -u
UA="https://github.com/user-attachments/assets"

get () {            # get <repo> <index> <uuid>
  local repo="$1" i="$2" uuid="$3"
  mkdir -p "images/$repo"
  local type
  type=$(curl -sLI "$UA/$uuid" | tr -d '\r' | awk -F': ' 'tolower($1)=="content-type"{print $2}' | tail -1)
  local ext="png"
  case "$type" in
    *webp*) ext="webp" ;;
    *jpeg*|*jpg*) ext="png" ;;   # saved as .png is fine only if it really is a png
    *gif*)  ext="png" ;;
  esac
  case "$type" in
    *jpeg*|*jpg*|*gif*|*mp4*|*quicktime*)
      echo "skip  $repo/r$i  ($type - convert it to png/webp by hand if you want it)"; return ;;
  esac
  if curl -sL -o "images/$repo/r$i.$ext" "$UA/$uuid"; then
    echo "saved images/$repo/r$i.$ext"
  else
    echo "FAILED $repo/r$i"
  fi
}

# repo                      idx  uuid
get vagabond                0 2cdfc134-11a7-4419-9480-be8d9cdfbafe
get vagabond                1 8f3f9aad-080e-4e97-b156-49bac0b7af5c
get vagabond                2 812ae3c7-b2a3-49dc-b2a8-2aa274d9823a
get vagabond                3 bdd42738-4d78-4199-8a49-1de9e6d92a09
get vagabond                4 15c8ba80-a0d2-4343-b6c3-5221cf7f096d

get investigation-board     0 5d78e7f3-c9ca-4aba-8894-f42035a21a2c
get investigation-board     1 3db14754-1884-48dd-87ac-6de9434c9c3f
get investigation-board     2 48162afa-0e73-424b-b49c-8140e9b27beb
get investigation-board     3 0f636b1c-8eda-489a-8074-0becf0927e42
get investigation-board     4 d16b91cd-e1f2-4067-9b33-93c56a9d2c83
get investigation-board     5 f5bec180-be0a-4b4f-828c-508eb1819c60

get metamorph               0 1a3411e1-a8d8-4dce-8314-aa15625ab338
get metamorph               1 bc8ea023-e888-4ed9-b9e8-0ef9806374ed
get metamorph               2 7d2cbbbd-d4e0-4679-9aed-4ec987b350d6
get metamorph               3 f3db253b-12c0-4bc7-b890-17b59ee8d085
get metamorph               4 f4dabac1-036b-4fc0-b7cb-6a8232a042bc

get daggerheart-hud         0 3467de17-da5a-42fb-b0a3-b92b6d0ec7db
get daggerheart-hud         1 e13ea1d6-726b-4cf4-9b3a-1c73011bfed0

get daggerheart-gm-hud      0 569ea625-be40-49c0-b9a4-c3c9aedbe13c
get daggerheart-gm-hud      1 e2c18bb2-f58c-4aec-b7c9-0423aaebcb33
get daggerheart-gm-hud      2 f7f5c9a2-49d0-428a-9330-c40391c92c54
get daggerheart-gm-hud      3 55af0288-a3c4-4b9a-a771-e768bc8e68f1

get tactical-map            0 55b116aa-aa0d-41c1-8d3a-0dc57686cd15
get tactical-map            1 7de3e12d-018c-4abb-be8d-b91bd4c4c453
get tactical-map            2 af073b58-4ea2-4809-8c2f-28fbd4b43fc5
get tactical-map            3 67ddc0b4-1104-481d-adad-33c0c73d008a
get tactical-map            4 b2589eec-8645-4213-b0cc-bb3c968ccada

get escalating-encounters   0 7ac29acc-799f-4743-b2df-d28a2a6a0933
get escalating-encounters   1 30d2afbb-3f72-429e-a971-45de63436db3
get escalating-encounters   2 47598ba5-a14c-4ad2-9faa-d1346be63a04
get escalating-encounters   3 db2f3a0a-2f13-407b-a5b3-60d6ee3f2b94

get macro-button            0 edb127df-694f-4cc6-9feb-555e0cc3df2b
get macro-button            1 06122815-61ed-466d-860c-9a2f2f8d7b6d

get vagabond-app-importer   0 46ad4ce3-d642-448a-8fe1-4e1b5501ed3d

get ccc-vagabond            0 fd5bd274-514a-46bd-bd0b-41f1bf38d720
get ccc-vagabond            1 f82b0f01-99de-4888-8ce8-6a478bf1ff3a
get ccc-vagabond            2 ea40d118-9652-4794-962f-2babeec7e05c

get art-for-daggerheart     0 1f6fca88-9c88-409c-81f3-234c0ecc724e
get art-for-daggerheart     1 ac460812-58af-433d-afbf-299c08f99728
get art-for-daggerheart     2 084f1980-3585-4f41-937b-28a89589fa7a

echo
echo "Done. The page loads images/<repo>/rN.webp or rN.png first and falls back"
echo "to the GitHub URL if the local file isn't there, so it works either way."
