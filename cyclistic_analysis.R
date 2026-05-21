# ============================================================
# CYCLISTIC BIKE-SHARE ANALYSIS
# Analista: Gabriel Almeida Alves
# Período: Maio 2025 - Abril 2026
# Objetivo: Entender diferenças entre membros e usuários casuais
# ============================================================

# PASSO 1 — Instalar e carregar pacotes
# (só precisa instalar uma vez; depois pode comentar as linhas install.packages)
install.packages("tidyverse")
install.packages("lubridate")
install.packages("scales")

library(tidyverse)
library(lubridate)
library(scales)

# ============================================================
# PASSO 2 — Carregar os 12 arquivos e combinar em um só
# ============================================================

caminho <- "/Users/gabrielalves/Documents/Estudo_de_caso/"

df <- list.files(path = caminho, pattern = "*.csv", full.names = TRUE) %>%
  lapply(read_csv) %>%
  bind_rows()

# Verificar estrutura
glimpse(df)
nrow(df)  # total de linhas

# ============================================================
# PASSO 3 — LIMPEZA DOS DADOS (fase Process)
# ============================================================

# 3.1 — Remover linhas com valores ausentes nas colunas essenciais
df_clean <- df %>%
  drop_na(started_at, ended_at, member_casual, rideable_type)

# 3.2 — Criar coluna ride_length (duração em minutos)
df_clean <- df_clean %>%
  mutate(ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")))

# 3.3 — Remover viagens inválidas (duração <= 0 ou > 24 horas)
df_clean <- df_clean %>%
  filter(ride_length > 0, ride_length <= 1440)

# 3.4 — Criar colunas de data/hora para análise
df_clean <- df_clean %>%
  mutate(
    day_of_week = wday(started_at, label = TRUE, abbr = FALSE, week_start = 1),
    month = month(started_at, label = TRUE, abbr = FALSE),
    hour_of_day = hour(started_at),
    season = case_when(
      month(started_at) %in% c(12, 1, 2) ~ "Winter",
      month(started_at) %in% c(3, 4, 5)  ~ "Spring",
      month(started_at) %in% c(6, 7, 8)  ~ "Summer",
      month(started_at) %in% c(9, 10, 11) ~ "Fall"
    )
  )

# Verificar resultado da limpeza
cat("Linhas após limpeza:", nrow(df_clean), "\n")
cat("Membros vs Casuais:\n")
table(df_clean$member_casual)

# ============================================================
# PASSO 4 — ANÁLISE DESCRITIVA (fase Analyze)
# ============================================================

# 4.1 — Resumo geral de duração por tipo de usuário
summary_geral <- df_clean %>%
  group_by(member_casual) %>%
  summarise(
    total_rides = n(),
    avg_duration_min = round(mean(ride_length), 1),
    median_duration_min = round(median(ride_length), 1),
    max_duration_min = round(max(ride_length), 1)
  )
print(summary_geral)

# 4.2 — Viagens por dia da semana
summary_weekday <- df_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(
    total_rides = n(),
    avg_duration_min = round(mean(ride_length), 1),
    .groups = "drop"
  )
print(summary_weekday)

# 4.3 — Viagens por mês
summary_month <- df_clean %>%
  group_by(member_casual, month) %>%
  summarise(
    total_rides = n(),
    avg_duration_min = round(mean(ride_length), 1),
    .groups = "drop"
  )
print(summary_month)

# 4.4 — Viagens por hora do dia
summary_hour <- df_clean %>%
  group_by(member_casual, hour_of_day) %>%
  summarise(
    total_rides = n(),
    .groups = "drop"
  )
print(summary_hour)

# 4.5 — Tipo de bicicleta por usuário
summary_bike_type <- df_clean %>%
  group_by(member_casual, rideable_type) %>%
  summarise(
    total_rides = n(),
    .groups = "drop"
  ) %>%
  group_by(member_casual) %>%
  mutate(pct = round(total_rides / sum(total_rides) * 100, 1))
print(summary_bike_type)

# 4.6 — Top 10 estações de início para usuários CASUAIS
# (importante para marketing: onde focar a comunicação)
top_stations_casual <- df_clean %>%
  filter(member_casual == "casual", !is.na(start_station_name)) %>%
  group_by(start_station_name) %>%
  summarise(total_rides = n(), .groups = "drop") %>%
  arrange(desc(total_rides)) %>%
  head(10)
print(top_stations_casual)

# 4.7 — Viagens por estação do ano
summary_season <- df_clean %>%
  group_by(member_casual, season) %>%
  summarise(
    total_rides = n(),
    avg_duration_min = round(mean(ride_length), 1),
    .groups = "drop"
  )
print(summary_season)

# ============================================================
# PASSO 5 — EXPORTAR RESULTADOS PARA O TABLEAU
# ============================================================

pasta_exports <- "/Users/gabrielalves/Documents/Estudo_de_caso/exports/"
dir.create(pasta_exports, showWarnings = FALSE)

write_csv(summary_geral,        paste0(pasta_exports, "01_summary_geral.csv"))
write_csv(summary_weekday,      paste0(pasta_exports, "02_rides_by_weekday.csv"))
write_csv(summary_month,        paste0(pasta_exports, "03_rides_by_month.csv"))
write_csv(summary_hour,         paste0(pasta_exports, "04_rides_by_hour.csv"))
write_csv(summary_bike_type,    paste0(pasta_exports, "05_bike_type.csv"))
write_csv(top_stations_casual,  paste0(pasta_exports, "06_top_stations_casual.csv"))
write_csv(summary_season,       paste0(pasta_exports, "07_rides_by_season.csv"))

cat("\n✅ ANÁLISE CONCLUÍDA! Arquivos exportados para:", pasta_exports, "\n")
cat("Total de viagens analisadas:", nrow(df_clean), "\n")
