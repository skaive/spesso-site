-- 02: configuracao compartilhada do planejamento do buffet Terrazza
-- KV simples: chave -> jsonb (ex.: 'plano' = {precoKg, regras:{categoria:{porDia,peso}}})
create table if not exists terrazza_config (
  chave text primary key,
  valor jsonb not null,
  atualizado_em timestamptz not null default now()
);

alter table terrazza_config enable row level security;

drop policy if exists "terrazza_config_select_anon" on terrazza_config;
create policy "terrazza_config_select_anon" on terrazza_config
  for select to anon using (true);

drop policy if exists "terrazza_config_insert_anon" on terrazza_config;
create policy "terrazza_config_insert_anon" on terrazza_config
  for insert to anon with check (true);

drop policy if exists "terrazza_config_update_anon" on terrazza_config;
create policy "terrazza_config_update_anon" on terrazza_config
  for update to anon using (true) with check (true);
