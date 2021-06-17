% @hidden
-module(jwerl_hs).

-export([sign/3, verify/4]).

-ifdef(OTP_RELEASE).
  -if(?OTP_RELEASE >= 24).

    sign(ShaBits, Key, Data) ->
      crypto:mac(hmac, algo(ShaBits), Key, Data).

  -elif(?OTP_RELEASE >= 21).

    sign(ShaBits, Key, Data) ->
      crypto:hmac(algo(ShaBits), Key, Data).

  -endif.
-else.

  sign(ShaBits, Key, Data) ->
    crypto:hmac(algo(ShaBits), Key, Data).

-endif.

verify(ShaBits, Key, Data, Signature) ->
  Signature == sign(ShaBits, Key, Data).


algo(256) -> sha256;
algo(384) -> sha384;
algo(512) -> sha512.
