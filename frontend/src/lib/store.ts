import { writable } from 'svelte/store';
import Fingerprint from './fingerprint';

export const selectedNavItem = writable<string>('');

export const currentFingerprint = writable<Fingerprint | null>(null);
export const fingerprintEnabled = writable<Boolean>(true);
export const showTracking = writable<Boolean>(true);